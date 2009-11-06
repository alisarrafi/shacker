require 'action_view/helpers/javascript_helper'

class Array
  
  include ActionView::Helpers::JavaScriptHelper
  
  def to_js_w
    "$w('" + self.escape_items_for_javascript.join(' ') + "')"
  end
  
  def to_js_array
    '["' + self.escape_items_for_javascript.join('", "') + '"]'
  end

  def shuffle
    sort_by { rand }
  end
  
  protected
  
  def escape_items_for_javascript
    self.map { |item| escape_javascript item.to_s }
  end

end