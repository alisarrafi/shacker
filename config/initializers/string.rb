require 'digest/sha2'

class String
  
  def hashed
    Digest::SHA2.hexdigest self
  end
  
end