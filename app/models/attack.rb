class Attack < ActiveRecord::Base




  def self.position
    return 1 unless result = find(:first, :order => 'position DESC')
    result
  end

end
