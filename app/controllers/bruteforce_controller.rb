class BruteforceController < ApplicationController
  
  def index
    render :action => 'pending' and return if solved?
  end

  def load
    position = Attack.position
    @options = {}
    @options[:client] = position + 1
    @options[:realm] = session[:settings].characters.size ** session[:settings].max
    @options[:offset] = offset :space => @options[:realm], :position => @options[:client]
    @options[:chunk] = chunk :offset => @options[:offset], :length => session[:settings].max, :characters => session[:settings].characters
    @options[:first_chunk] = chunk :offset => 1, :length => session[:settings].max, :characters => session[:settings].characters
    @options[:last_chunk] = chunk :offset => @options[:realm], :length => session[:settings].max, :characters => session[:settings].characters
    @options[:report_interval] = session[:settings].assumed
    @options[:solution_url] = url_for :action => 'solution', :password => 'PASSWORDPLACEHOLDER', :client => @options[:client]
    @options[:script_url] = url_for(:action => nil) + 'javascripts/shacker.js'
    Attack.create :position => @options[:client], :chunk => @options[:chunk], :offset => @options[:offset]
    respond_to do |format|
      format.js
    end
  end
  
  def respond
    render :text => 'OK'
  end
  
  def solution
    if params[:password].to_s == session[:settings].secret
      if solved? 
        render :action => 'solved' and return
      else
        solve! params[:password].to_s
        render :action => 'congratulations' and return
      end
    end
    render :action => 'sorry' and return
  end

  def settings
    if request.put?
      session[:settings].secret = params[:settings][:secret].to_s
      session[:settings].mode = params[:settings][:mode].to_s
      session[:settings].max = params[:settings][:max].to_i.to_positive_i
      session[:settings].mix = params[:settings][:mix].to_i
      session[:settings].assumed = params[:settings][:assumed].to_i.to_positive_i
      if session[:settings].valid_secret?
        session[:settings] = session[:settings].save
        flash[:notice] = 'Settings saved.'
      else
        flash[:error] = 'Please provide a valid password according to the selected <b>mode</b> and <b>length</b>.'
      end
    end
    if params[:toggle]
      if solved?
        unsolve!
        Attack.reset
        flash[:notice] = 'The challenge has begun.'
      else
        solve! session[:settings].secret
        flash[:warning] = 'The current challenge was stopped'
      end
    end
    @realm = session[:settings].characters.size ** session[:settings].max
    respond_to do |format|
      format.html
      format.json { render :json => session[:settings].to_json }
      format.yml { render :text => session[:settings].to_yaml }
    end
  end

end
