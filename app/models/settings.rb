require 'yaml'

class Settings
    
  attr_accessor :secret, :mode, :max, :mix, :assumed, :character_space
  attr_reader :characters

  def initialize
    @mode = 'demo'
    @character_space = 'alpha'
    @secret = 'sha'
    @max = 3
    @assumed = 100000
    @mix = 0
    @characters = characters_array @mix
  end
  
  # Loading settings from settings.yml
  def read
    settings = YAML.load_file SETTINGS_FILE
    [:secret, :mode, :max, :mix, :assumed, :character_space, :characters].each { |attribute| instance_eval "@#{attribute.to_s} = settings.#{attribute.to_s}" }
    self
  end
  
  # Save settings object to file
  def save
    @characters = characters_array @mix
    File.open(SETTINGS_FILE, 'w') { |file| file.write YAML::dump(self) }
    self
  end
  
  def characters_array(mix)
    case @character_space
      when 'alpha' then result = ALPHA
      when 'alnum' then result = ALPHA + DIGITS
      when 'digit' then result = DIGITS
      when 'ascii' then result = ALPHA + DIGITS + SPECIAL_CHARS
    end
    return mix == 1 ? result.shuffle : result
  end
  
  def character_space_short
    case @character_space
      when 'alpha' then 'a-z'
      when 'alnum' then 'A-Z a-z 0-9'
      when 'digit' then '0-9'
      when 'ascii' then 'A-Z a-z 0-9 ' + SPECIAL_CHARS.join(' ')
    end
  end
  
  def valid_secret?
    return false if @secret.empty? or @secret.size != @max
    case @character_space
      when 'alpha' then !(@secret =~ /[^a-zA-Z]/)
      when 'alnum' then !(@secret =~ /[^a-zA-Z0-9]/)
      when 'digit' then !(@secret =~ /[^0-9]/)
      when 'ascii' then !(@secret =~ Regexp.new('[^a-zA-Z0-9' + Regexp.escape(SPECIAL_CHARS.join) + ']'))
    end    
  end
  
  # Reset Settings and save to file
  def self.reset
    new.save
  end
    
  def self.maxes; (1..10).map { |i| [i, i] } end
  def self.mixes; [["Yes", 1], ["No", 0]] end
  
  # For formtastic only
  def id; 1 end
  def new_record?; false end
  def self.human_name; "Settings" end
  
  protected
  
  def update_characters
    @characters = characters_array @mix
  end

end