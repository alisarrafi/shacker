require 'yaml'

class Settings
    
  attr_accessor :secret, :mode, :max, :mix
  attr_reader :specials, :alphas, :digits, :modes_semantic, :characters
    
  @@modes = [['Only alphabetical characters', 'alpha'], ['Alphabetical characters and numbers', 'alnum'], ['Only numbers', 'digit'], ['Numbers, alphabetical and special characters', 'ascii']].freeze

  def initialize
    @max = 4
    @mix = 1
    @secret = 'test'
    @mode = 'ascii'
    @alphas, @digits = [], []
    @specials = ['!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '§', '='].freeze
    ('a'..'z').each { |char| @alphas << char.to_s }
    ('A'..'Z').each { |char| @alphas << char.to_s }
    (0..9).each { |digit| @digits << digit.to_s }
    @alphas.freeze
    @digits.freeze
    @characters = character_space.shuffle
  end

  def read
    settings = YAML.load_file SETTINGS_FILE
    [:secret, :mode, :specials, :alphas, :digits, :modes_semantic, :characters, :max].each { |attribute| instance_eval "@#{attribute.to_s} = settings.#{attribute.to_s}" }
    self
  end
  
  def save
    @characters = @mix == 1 ? character_space.shuffle : character_space
    File.open(SETTINGS_FILE, 'w') { |file| file.write YAML::dump(self) }
    self
  end
  
  def character_space
    case @mode
      when 'alpha' then @alphas
      when 'alnum' then @alphas + @digits
      when 'digit' then @digits
      when 'ascii' then @alphas + @digits + @specials
    end
  end
  
  def character_space_short
    case @mode
      when 'alpha' then 'a-z'
      when 'alnum' then 'A-Z a-z 0-9'
      when 'digit' then '0-9'
      when 'ascii' then 'A-Z a-z 0-9 ' + @specials.join(' ')
    end
  end
  
  def valid_secret?
    return false if @secret.empty?
    case @mode
      when 'alpha' then !(@secret =~ /[^a-zA-Z]/)
      when 'alnum' then !(@secret =~ /[^a-zA-Z0-9]/)
      when 'digit' then !(@secret =~ /[^0-9]/)
      when 'ascii' then !(@secret =~ Regexp.new('[^a-zA-Z0-9' + Regexp.escape(@specials.join) + ']'))
    end    
  end
    
  def self.modes; @@modes end
  def self.maxes; (1..10).map { |i| [i, i] } end
  def self.mixes; [["Yes", 1], ["No", 0]] end
  def id; 1 end
  def new_record?; false end
  def self.human_name; "Settings" end

end