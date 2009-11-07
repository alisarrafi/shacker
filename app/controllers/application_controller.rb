class ApplicationController < ActionController::Base
  
  helper :all
  protect_from_forgery
  
  before_filter :load_settings  
  
  protected
  
  def load_settings
    flash[:notice] = nil # (Hack for Safari flash caching bugs)
    flash[:warning] = nil
    flash[:error] = nil
    session[:settings] = Settings.new.read
  end
  
end
