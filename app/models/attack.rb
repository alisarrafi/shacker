class Attack < ActiveRecord::Base

  def timespan
    updated_at - created_at
  end

  def self.reset
    Attack.delete_all
  end
  
  def self.save_report(client, counter)
    return unless counter.to_i > 0 and result = find_by_client(client.to_s)
    update result.id, :response => counter.to_i
  end
  
  def self.increment_position! 
    return 0 unless result = find(:first, :order => 'position DESC')
    if result.increment! 'position'
      return result.position
    else
      raise 'Could not increment position.'
    end
  end

  def self.current_position
    return 0 unless result = find(:first, :order => 'position DESC')
    result.position
  end

end
