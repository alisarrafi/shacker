class Attack < ActiveRecord::Base

  def self.reset
    Attack.delete_all
  end

  def self.in_progress?
    self.class.position > 0
  end

  def self.position
    return 0 unless result = find(:first, :order => 'position DESC')
    result.position
  end

end
