require 'yaml'

class Settings
    
  attr_accessor :secret, :mode, :max, :mix, :assumed
  attr_reader :characters

  def initialize
    @mode = 'ascii'
    @secret = 'test'
    @max = 4
    @assumed = 100000
    @mix = 1
    @characters = character_space.shuffle
  end
  
  # Loading settings from settings.yml
  def read
    settings = YAML.load_file SETTINGS_FILE
    [:secret, :mode, :max, :mix, :characters, :assumed].each { |attribute| instance_eval "@#{attribute.to_s} = settings.#{attribute.to_s}" }
    self
  end
  
  def save
    @characters = @mix == 1 ? character_space.shuffle : character_space
    File.open(SETTINGS_FILE, 'w') { |file| file.write YAML::dump(self) }
    self
  end
  
  def character_space
    case @mode
      when 'alpha' then ALPHA
      when 'alnum' then ALPHA + DIGITS
      when 'digit' then DIGITS
      when 'ascii' then ALPHA + DIGITS + SPECIAL_CHARS
    end
  end
  
  def character_space_short
    case @mode
      when 'alpha' then 'a-z'
      when 'alnum' then 'A-Z a-z 0-9'
      when 'digit' then '0-9'
      when 'ascii' then 'A-Z a-z 0-9 ' + SPECIAL_CHARS.join(' ')
    end
  end
  
  def valid_secret?
    return false if @secret.empty?
    case @mode
      when 'alpha' then !(@secret =~ /[^a-zA-Z]/)
      when 'alnum' then !(@secret =~ /[^a-zA-Z0-9]/)
      when 'digit' then !(@secret =~ /[^0-9]/)
      when 'ascii' then !(@secret =~ Regexp.new('[^a-zA-Z0-9' + Regexp.escape(SPECIAL_CHARS.join) + ']'))
    end    
  end
    
  def self.maxes; (1..10).map { |i| [i, i] } end
  def self.mixes; [["Yes", 1], ["No", 0]] end
  
  # For formtastic only
  def id; 1 end
  def new_record?; false end
  def self.human_name; "Settings" end

end