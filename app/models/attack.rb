class Attack < ActiveRecord::Base




  def self.in_progress?
    find(:first) ? true : false
  end

end
