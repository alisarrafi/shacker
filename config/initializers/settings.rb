# File paths
SETTINGS_FILE = File.join Rails.root, 'config', 'settings.yml'
SOLUTION_FILE = File.join Rails.root, 'tmp', 'solution.txt'
CLIENT_FILE = File.join Rails.root, 'tmp', 'client.txt'

# Characters
ALPHA_DOWN = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
ALPHA_CAP  = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
ALPHA = ALPHA_DOWN + ALPHA_CAP
SPECIAL_CHARS = [" ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "\\", "]", "^", "_", "`", "{", "|", "}", "~"]
DIGITS    = ['0','1','2','3','4','5','6','7','8','9']

# Character modes
CHARACTER_SPACES = [['Only alphabetical characters', 'alpha'],
                   ['Alphabetical characters and numbers', 'alnum'],
                   ['Only numbers', 'digit'],
                   ['The entire 95 characters ASCII table', 'ascii']]

# Regexps for character modes
REG_ALPHA = /[^a-zA-Z]/
REG_ALNUM = /[^a-zA-Z0-9]/
REG_DIGIT = /[^0-9]/
REG_ASCII = /[^\x20-\x7E]/
#REG_ASCII = Regexp.new('[^a-zA-Z0-9' + Regexp.escape(SPECIAL_CHARS.join) + ']')

# Same thing only human-readable
HUMAN_ALPHA = 'a-z A-Z'
HUMAN_ALNUM = 'A-Z a-z 0-9'
HUMAN_DIGIT = '0-9'
HUMAN_ASCII = 'A-Z a-z 0-9 ' + SPECIAL_CHARS.join(' ')

# Application modes
MODES = [['Normal mode', 'normal'],
        ['Demo mode (no solutions, no database)', 'demo'],
        ['Mass mode (no client response evaluation but highly scalable)', 'mass']]

# Javascript list for developers
JAVASCRIPTS = ['prototype', 'effects', 'lowpro', 'helper', 'sha256', 'algorithm']

# Client modes
PRESETS = [['client', 'For our own HTML interface'], ['facebook', 'A low-duty version for Facebook profiles']]

solve! # We do not want everything to begin unless via settings
Attack.reset
