class Fixnum

  def offset(position=1)
    return 0 if position <= 1 or self <= 1 or self < position
    return (position - 1) if self <= 3
    return (self - 1) if self == position and odd?
    case position
      when 2 then return even? ? ((self / 2) + 1) : (self / 2)
      when 3 then return ((self / 4) + 1)
      when 4 then return even? ? (self - (self / 4)) : (self - (self / 4) + 1)
      else
        slice = self / position.positions_in_row
        slice * (position - (position.max_in_row / 2))
    end 
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