require 'yaml'

class Settings
  
  attr_accessor :secret, :mode
  attr_reader :specials, :alphas, :digits, :modes_semantic, :characters
    
  @@modes = [['alpha', 'alpha'], ['alnum', 'alnum'], ['digit', 'digit'], ['ascii', 'ascii']].freeze

  def initialize
    @secret = 'test'
    @mode = 'ascii'
    @alphas, @digits = [], []
    @specials = ['!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/'].freeze
    ('a'..'z').each { |char| @alphas << char.to_s }
    ('A'..'Z').each { |char| @alphas << char.to_s }
    (0..9).each { |digit| @digits << digit.to_s }
    @alphas.freeze
    @digits.freeze
    @characters = character_space.shuffle
  end

  def read
    settings = YAML.load_file SETTINGS_FILE
    [:secret, :mode, :specials, :alphas, :digits, :modes_semantic, :characters].each { |attribute| instance_eval "@#{attribute.to_s} = settings.#{attribute.to_s}" }
    self
  end
  
  def save
    @characters = character_space.shuffle 
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
  
  def self.modes; @@modes end
  def id; 1 end
  def new_record?; false end
  def self.human_name; "Settings" end

end