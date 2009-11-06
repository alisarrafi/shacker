class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :load_settings  
  
  protected
  
  def load_settings
    flash[:notice] = nil # (Bad hack for Safari flash caching bugs)
    session[:settings] = Settings.new.read unless session[:settings].is_a? Settings
  end
  
end
