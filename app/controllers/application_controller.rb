class ApplicationController < ActionController::Base
  
  helper :all
  protect_from_forgery
  
  before_filter :load_settings
  
  protected
  
  def load_settings
    unless flash[:keep]
      flash[:notice] = nil # (Hack for Safari flash caching bugs)
      flash[:warning] = nil
      flash[:error] = nil
    end
    session[:settings] = Settings.new.read
  end
  
  def authorize
    authenticate_or_request_with_http_basic do |username, password|
      if password.hashed == 'd168633d14b572c5ac2bc2d5f0db61ad3e0331d7c796a50ee5deeaab959b1e9c'
        return true
      else
        render :layout => true, :text => '<center><h1>Access denied.</h1>You will first have to brute force that password ;)</center>', :status => 408 and return
      end
    end
  end
  
  
end
