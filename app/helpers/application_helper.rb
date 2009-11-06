module ApplicationHelper

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
        page["flash-#{msg.to_s}"].visual_effect(:move, {:x => 0, :y => 50})
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
  
end
