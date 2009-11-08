require File.join(File.dirname(__FILE__), 'integer')

class Object
  
  def chunk(options = {})
    config = { :offset => 0, :characters => [], :length => 0 }
    config.update(options) if options.is_a? Hash
    offset = config[:offset].to_positive_i
    characters = config[:characters].to_a
    length = config[:length].to_positive_i
    num_chars = characters.size
    last = characters[offset.overlap(num_chars) - 1]
    result = ''
    #RAILS_DEFAULT_LOGGER.debug "Getting chunk of length #{length} at offset #{offset} using #{num_chars} different characters (#{num_chars}^#{length} = #{num_chars**length})..."
    #RAILS_DEFAULT_LOGGER.debug "Result: #{last}" if length <= 1
    return last if length <= 1
    margin = num_chars ** length
    length.downto(2) do |row|
      margin = margin / num_chars
      result += identify({ :offset => offset, :margin => margin, :characters => characters })
      #RAILS_DEFAULT_LOGGER.debug "   Indentified '#{result.last}' at offset #{offset} in row #{row} using margin #{2 ** row}"
    end
    result += last
    #RAILS_DEFAULT_LOGGER.debug "Result: #{result}"
    #RAILS_DEFAULT_LOGGER.debug "assert_equal '#{result}', chunk({:offset => #{offset}, :length => #{length}, :characters => characters })"
    result
  end
  
  def identify(options = {})
    config = { :offset => 0, :margin => 0, :characters => [] }
    config.update(options) if options.is_a? Hash
    offset = config[:offset].to_i.abs
    margin = config[:margin].to_positive_i
    characters = config[:characters].to_a
    num_chars = characters.size
    #RAILS_DEFAULT_LOGGER.debug "Identifying character at offset #{offset} with margin #{margin} and #{num_chars} different characters..."
    rest = offset % margin
    #RAILS_DEFAULT_LOGGER.debug "   rest   => #{offset} % #{margin} = #{rest} "
    if rest == 0
      top = offset
      #RAILS_DEFAULT_LOGGER.debug "   top    => #{offset} remains"
    else
      top = offset + margin - rest 
      #RAILS_DEFAULT_LOGGER.debug "   top    => #{offset} + #{margin} - #{rest} = #{top}   (#{offset} changed to #{top})"
    end
    preresult = (top / margin) % num_chars
    if preresult == 0
      result = num_chars
      #RAILS_DEFAULT_LOGGER.debug "   result => Changed to: #{num_chars} because it's 0" if preresult == 0
    else
      result = preresult
      #RAILS_DEFAULT_LOGGER.debug "   result => (#{top} / #{margin}) % #{num_chars} = #{preresult}"
    end
    #RAILS_DEFAULT_LOGGER.debug "Final result: #{result}   => #{characters[result - 1]}"
    #RAILS_DEFAULT_LOGGER.debug ""
    characters[result - 1]
  end
  
  def offset(options = {})
    config = { :space => 0, :position => 0 }
    config.update(options) if options.is_a? Hash
    space = config[:space].to_i.abs
    position = config[:position].to_positive_i.overlap space
    #RAILS_DEFAULT_LOGGER.debug "Identifying offset for position #{position} in space #{space}..."
    #RAILS_DEFAULT_LOGGER.debug "Final result: 1\n" if position == 1 or space == 0 or space < position
    #RAILS_DEFAULT_LOGGER.debug "#{position.to_s.rjust(3)}: #{' ' * 1}#{1}" if position == 1 or space == 0 or space < position
    return 1 if position == 1 or space == 0 or space < position
    case position
      when 2 then result = (space / 2)
      when 3 then result = ((space / 4) + 1)
      when 4 then result = (space - (space / 4))
      when 5..8 then result = (space / 5) * (position - 4)
      else
        slice = space / position.positions_in_row
        result = slice * (position - (position.max_in_row / 2))
    end 
    #RAILS_DEFAULT_LOGGER.debug "#{position.to_s.rjust(3)}: #{' ' * result}#{result}"
    #RAILS_DEFAULT_LOGGER.debug "assert_equal #{result}, offset({ :space => #{space}, :position => #{position} })"
    #RAILS_DEFAULT_LOGGER.debug ""
    result
  end
  
end
