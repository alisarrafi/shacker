class BruteforceController < ApplicationController
  
  def index
  end

  def load
    @options = {}
    @options[:realm] = session[:settings].characters.size ** session[:settings].max
    @options[:client] = Attack.position
    @options[:offset] = @options[:realm].offset @options[:client]
    @options[:scriptfile] = url_for(:action => nil) + 'javascripts/shacker.js'
    respond_to do |format|
      format.js
    end
  end
  
  def respond
    render :text => 'OK'
  end
  
  def solution    
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
        flash[:warning] = 'Please provide a valid password according to the selected mode.'
      end
    end
    respond_to do |format|
      format.html
      format.json { render :json => session[:settings].to_json }
    end
  end
  
  #def chunks
  #  @chunks = []
  #  string = ' '
  #  4000.times do |i|
  #    string = string.succ
  #    @chunks << string
  #  end
  #  respond_to do |format|
  #    format.html { render :text => @chunks.inspect }
  #    format.js   { render :js => "chunks = #{@chunks.to_js_array};" }
  #    format.json { render :json => @chunks.to_json }
  #  end
  #end
  
  #def characters
  #  respond_to do |format|
  #    format.html { render :text => session[:settings].characters, :content_type => 'text/plain' }
  #    format.json { render :json => session[:settings].characters.to_json }
  #    format.js   { render :js => "characters = #{session[:settings].characters.to_js_array};" }
  #  end
  #end
  #
  #def secret
  #  respond_to do |format|
  #    format.html { render :text => session[:settings].secret.hashed, :content_type => 'text/plain' }
  #    format.json { render :json => session[:settings].secret.hashed.to_json }
  #    format.js   { render :js => "secret = '#{session[:settings].secret.hashed}';" }
  #  end
  #end
 
end
