require 'digest/sha2'
require 'action_view/helpers/javascript_helper'

class String
  
  include ActionView::Helpers::JavaScriptHelper
  
  def hashed
    Digest::SHA2.hexdigest self
  end
  
  def to_success; self.color_span('green') end
  def to_error; self.color_span('red') end
  
  protected
  
  def color_span(color='black')
    "<span style='color: #{color};'>#{self}</span>"
  end
  
end