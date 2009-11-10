module ApplicationHelper

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
