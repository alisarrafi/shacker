class BruteforceController < ApplicationController
  
  def index
  end

  def load
    position = Attack.position
    @options = {}
    @options[:realm] = session[:settings].characters.size ** session[:settings].max
    @options[:client] = position
    @options[:offset] = @options[:realm].offset @options[:client]
    @options[:scriptfile] = url_for(:action => nil) + 'javascripts/shacker.js'
    @options[:chunk] = chunk :offset => position, :length => session[:settings].max, :characters => session[:settings].characters
    @options[:first_chunk] = chunk :offset => 1, :length => session[:settings].max, :characters => session[:settings].characters
    @options[:last_chunk] = chunk :offset => @options[:realm], :length => session[:settings].max, :characters => session[:settings].characters
    respond_to do |format|
      format.js
    end
  end
  
  def respond
    render :text => 'OK'
  end
  
  def solution    
    render :text => 'OK'
  end

  def settings
    flash[:notice] = nil
    if request.put?
      session[:settings].secret = params[:settings][:secret].to_s
      session[:settings].mode = params[:settings][:mode].to_s
      session[:settings].max = params[:settings][:max].to_i
      session[:settings].mix = params[:settings][:mix].to_i
      if session[:settings].valid_secret?
        session[:settings] = session[:settings].save
        flash[:notice] = 'Settings saved.'
      else
        flash[:error] = 'Please provide a valid password according to the selected <b>mode</b> and <b>length</b>.'
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
