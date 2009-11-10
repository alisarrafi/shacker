class Integer
  
  def overlap(length)
    return 0 if self == 0 or length == 0
    result = self % length
    result = result == 0 ? length : result
    #RAILS_DEFAULT_LOGGER.debug "  Overlaping #{self} to #{result} using length #{length}"
    result
  end
  
  def positions_in_row
    return 0 if self <= 0
    return 2 if self <= 4
    max_in_row / 2
  end
  
  def max_in_row
    return 0 if self <= 0
    return 2 if self <= 2
    n = 2
    while true do
      n = n * 2
      return n if self <= n
    end
  end
  
end
