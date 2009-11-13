class BruteforceController < ApplicationController
  
  before_filter :authorize, :only => [:reset, :settings, :toggle, :status]
  
  # Start brute force
  def index
    session[:solved] = nil
    render :action => 'pending' and return if solved? and !demo_mode
  end

  # Get client JavaScript for the HTML client
  def client
    session[:solved] = nil
    render :action => 'pending.js' and return if solved? and !demo_mode
    if demo_mode
      @options = default_client_options 1     
      @options[:report_interval] = 0
    elsif mass_mode
      Attack.reset if Attack.count > 1
      Attack.create(:position => 0) if Attack.count == 0
      @options = default_client_options Attack.increment_position!
    else
      @options = default_client_options(position = Attack.count + 1, random_string)
      last = Attack.create :position => @options[:position], :chunk => @options[:chunk], :xoffset => @options[:offset], :client => @options[:client]
    end
    if params[:option] == 'facebook'
      @options[:status_interval] = 5
      @options[:status_delay]    = 500
      @options[:loop_delay]      = 500
    end
    @descriptions = option_descriptions @options
    respond_to do |format|
      format.js
    end
  end
  
  # Hand in a response interval
  def report
    render :js => '// Currently we don\'t keep track of reports. Thank you!' and return unless normal_mode
    render :js => "// Sorry, but the solution was already handed in by somebody else!\n// Let's refresh your browser (twice, to go sure ;).\nwindow.location.reload();\nwindow.location.reload();" and return if solved? and !demo_mode
    Attack.save_report params[:client], params[:counter]
    render :js => '// Thank you for your report!'
  end
  
  # Hand in a solution
  def solution
    if params[:password].to_s.hashed == session[:settings].sha
      if solved? and !demo_mode and solved_by? != params[:client].to_s
        render :action => 'alreadysolved' and return
      else
        session[:solved] = params[:password].to_s
        @password = params[:password].to_s
        solve!(params[:password].to_s, params[:client].to_s) unless demo_mode
        render :action => 'congratulations' and return
      end
    end
    render :action => 'sorry' and return
  end
  
  def statistics
    order = 'response'
    session[:updown] = params[:updown].to_s
    if Attack.column_names.include? params[:sort].to_s
      order = params[:sort].to_s
    end
    session[:updown] = 'DESC' unless session[:updown].to_s == 'ASC' or session[:updown].to_s == 'DESC'
    @attacks = Attack.find(:all, :order => order + ' ' + session[:updown], :limit => 400)
    @realm = session[:settings].characters.size.to_i ** session[:settings].max.to_i
    @solution = what_is_the_solution?
    @client = solved_by?
    render :layout => 'status'
  end
  
  # Reset to default settings
  def reset
    solve!
    Settings.reset
    Attack.reset
    flash[:keep] = true # (Hack for Safari flash caching bugs)
    flash[:warning] = 'Settings have been restored to default.'
    redirect_to :action => 'settings'
  end

  # Show and edit settings
  def settings
    if request.put?
      session[:settings].secret = params[:settings][:secret].to_s
      session[:settings].character_space = params[:settings][:character_space].to_s
      session[:settings].mode = params[:settings][:mode].to_s
      session[:settings].max = params[:settings][:max].to_positive_i
      session[:settings].mix = params[:settings][:mix].to_i
      session[:settings].assumed = params[:settings][:assumed].to_positive_i
      if session[:settings].valid_secret?
        session[:settings] = session[:settings].save
        flash[:notice] = 'Settings saved.'
      else
        flash[:error] = 'Please provide a valid password according to the <b><u>valid characters</u></b> and <b><u>length</u></b>.'
      end
    end
    @realm = session[:settings].characters.size ** session[:settings].max
    respond_to do |format|
      format.html
      format.json { render :json => session[:settings].to_json }
      format.yml { render :text => session[:settings].to_yaml }
    end
  end
  
  # Toggles the solution.txt file and updates "Begin Challenge" button's label text
  def toggle
    if solved?
      unsolve!
      Attack.reset
      flash[:notice] = 'The challenge has begun.'
    else
      solve!
      flash[:warning] = 'The current challenge was stopped'
    end
    respond_to do |format|
      format.js
    end
  end
  
  # Returns JavaScript to refresh the "Begin Challenge" button's label text 
  def toggle_status
    render :action => 'toggle.js'
  end
  
  protected
  
  # Returns whether we are in normal mode
  def normal_mode
    session[:settings].mode == 'normal'
  end
  
  # Returns whether we are in mass mode
  def mass_mode
    session[:settings].mode == 'mass'
  end
  
  # Returns whether we are in demo mode
  def demo_mode
    session[:settings].mode == 'demo'
  end
  
  # Setting the general options for every cliend
  def default_client_options(position, id=0)
    result = {}
    # Static values
    result[:secret]          = session[:settings].sha
    result[:characters]      = session[:settings].characters
    result[:length]          = session[:settings].max
    result[:realm]           = result[:characters].size ** result[:length]
    # Chunk values
    result[:client]          = id
    result[:position]        = position
    result[:offset]          = offset :space => result[:realm], :position => result[:position]
    result[:chunk]           = chunk :offset => result[:offset], :length => session[:settings].max, :characters => session[:settings].characters
    result[:init_chunk]      = result[:chunk]
    result[:first_chunk]     = chunk :offset => 1, :length => session[:settings].max, :characters => session[:settings].characters
    result[:last_chunk]      = chunk :offset => result[:realm], :length => session[:settings].max, :characters => session[:settings].characters
    # Options
    result[:report_interval] = session[:settings].assumed
    result[:status_interval] = 1000
    result[:status_delay]    = 150
    result[:loop_delay]      = 0
    result[:solution_url]    = url_for :action => 'solution', :password => 'PASSWORDPLACEHOLDER', :client => result[:client]
    result[:report_url]      = url_for :action => 'report', :counter => 'COUNTERPLACEHOLDER', :client => result[:client]
    result[:script_url]      = url_for(:action => nil) + 'javascripts/shacker.js'
    # Return value
    result
  end
  
  # Defining help texts for the options hash
  def option_descriptions(options)
    result = {}
    # Static values
    result[:secret]          = "This is the secret password we're looking for.\nIt's SHA-256 encrypted and we assume it's exactly #{options[:length]} characters long."
    result[:characters]      = "These are all valid characters for the password.\nI.e. the secret password contains only these character."
    result[:length]          = "This is what we assume about the password length.\nIt's exactly #{options[:length]} characters long."
    result[:realm]           = "With the given number of valid characters (#{options[:characters].size.to_delimiter_s}) and the length of the password (#{options[:length]})\nwe can calculate the number of all possible password combinations (#{options[:characters].size.to_delimiter_s}^#{options[:length]} = #{(options[:characters].size ** options[:length]).to_delimiter_s})."
    # Chunk values
    result[:client]          = "Your unique client ID. If it's 0 then we don't keep track of the clients at the moment."
    result[:position]        = "Of all Clients participating in brute forcing this password, you are number #{options[:position].to_delimiter_s}"
    result[:offset]          = "For the given position #{options[:position].to_delimiter_s}, this is the offset among the realm of possible passwords. \nThe first offset is 1 and #{options[:realm].to_delimiter_s} is the last)."
    result[:chunk]           = "This is the first password that we would like this client to try.\nIf you align all possible passwords of the realm next to each other, \nthis is password at offset #{options[:offset].to_delimiter_s}"
    result[:init_chunk]      = "Just a copy of 'chunk', because the client might want to change that variable in-place."
    result[:first_chunk]     = "The first possible password in the password realm with the given characters."
    result[:last_chunk]      = "The last possible password in the password realm with the given characters."
    # Options
    result[:report_interval] = "After #{options[:report_interval].to_delimiter_s} tried passwords, we would like the client to respond to the server.\nIf zero, there should be no response at all."
    result[:status_interval] = "After #{options[:status_interval].to_delimiter_s} tried passwords, the client will attemt to update the status-DIV."
    result[:status_delay]    = "Each time the status div is updated, the client will wait #{options[:status_delay]} milliseconds\nbefore it continues brute forcing. Because the browser needs to take some \nbreath before it performs any DOM manipulation."
    result[:loop_delay]      = "For certain client applications, we want the client to wait this number of milliseconds between \nevery password try.If you include our script in a public site, you would want this to be \naround half a second (i.e. 500) to not disturb the user."
    result[:solution_url]    = "When the client found the password, redirect/report it to this URL, please.\nMake sure the placeholder is replaced and it's URL-encoded!!!\nExample: solution_url.sub('PASSWORDPLACEHOLDER', encodeURIComponent(String.interpret(password)));"
    result[:report_url]      = "The client is supposed to call this URL every #{options[:report_interval]} password tries (see 'report_interval').\nSince this is an integer, you don't need to URI-encode it, but do replace the placeholder!\nExample: report_url.sub('COUNTERPLACEHOLDER', counter);"
    result[:script_url]      = "This is the JavaScript library that you need to run everything of this in first place.\nIt includes Prototype, Scriptaculous Effects, LowPro, SHA256 and Shacker."
    # Return value
    result  
  end

end
