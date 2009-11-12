module ApplicationHelper

  def solved_item(left=0, width=0, offset=0, password='')
    return if left < 1 and width < 1
    result = ''
    result += '<div style="left:' + (left - 20).to_s + 'px; position:absolute; top:13px; color:red; font-size:13px; background-color:white; z-index:10000;">' + offset.to_delimiter_s + '</div>'
    result += '<div style="left:' + left.to_s + 'px; width:' + width.to_s + 'px; position:absolute; top:31px; height:30px; background-color: red; z-index:10000;"></div>'
    result += '<div style="left:' + (left - 20).to_s + 'px; position:absolute; top:63px; color:red; font-size:16px; background-color:white; z-index:10000;">' + password.to_s + '</div>'
  end

  def progress_item(left=0, width=0, offset=0)
    return if left < 1 and width < 1
    left = left + 31
    width = width + 2
    result = ''
    result += '<div style="left:' + (left - 10).to_s + 'px; position:absolute; top:19px; font-size:9px; background-color:white;">' + offset.to_delimiter_s + '</div>' if left > 45 and left < 950
    result += '<div style="left:' + left.to_s + 'px; width:' + width.to_s + 'px; position:absolute; top:31px; height:30px; background-color: yellow;"></div>'
  end

  def other_updown
    session[:updown] == 'DESC' ? 'ASC' : 'DESC'
  end

  def extend_flash_messages
    [:notice, :warning, :error].each do |msg|
      next if flash[msg].blank?
      flash[msg] += ' ' + button_to_function("OK", :id => "flash-killer-#{msg.to_s}") do |page|
        page["flash-#{msg.to_s}"].visual_effect(:move, {:x => 0, :y => -100})
        page["flash-#{msg.to_s}"].visual_effect :fade
      end
    end
  end

  def animate_flash_messages
    result = ''
    [:error, :warning, :notice].each do |msg|
      next if flash[msg].blank?
      result += javascript_tag update_page { |page|
        page.call 'centerflash', "flash-#{msg.to_s}"
        page["flash-#{msg.to_s}"].visual_effect(:move, {:x => 0, :y => browser == 'firefox' ? 0 : 50})
        page["flash-#{msg.to_s}"].appear
      }
      next if msg == :error
      result += javascript_tag update_page { |page|
        page.delay(5) do
          page["flash-killer-#{msg.to_s}"].click
        end
      }
    end
    result
  end
  
  def browser
    case request.env["HTTP_USER_AGENT"]
    when /AppleWebKit/ then 'safari'
    when /MSIE/ then 'ie'
    when /Opear/ then 'opera'
    when /Firefox/ then 'firefox'
    else
      'other'
    end
  end
  
  def test_scripts
    ["      " + url_for(:action => nil, :only_path => false) + "javascripts/test_helper.js"]
  end
  
  def javascripts
    result = []
    JAVASCRIPTS.each { |script| result << "      " + url_for(:action => nil, :only_path => false) + "javascripts/#{script}.js" }
    result
  end
  
  def presets
    result = []
    PRESETS.each { |preset| result << "      " + url_for(:action => nil, :only_path => false) + "#{preset.first}.js".ljust(longest_preset + 10) + "(#{preset.last})" }
    result
  end
  
  def longest_preset
    PRESETS.max { |a,b| a.first.length <=> b.first.length }.first.size
  end
  
end
