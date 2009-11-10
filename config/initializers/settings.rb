SETTINGS_FILE = File.join Rails.root, 'config', 'settings.yml'
SOLUTION_FILE = File.join Rails.root, 'tmp', 'solution.txt'

CHARACTER_SPACES = [['Only alphabetical characters', 'alpha'],
                   ['Alphabetical characters and numbers', 'alnum'],
                   ['Only numbers', 'digit'],
                   ['Numbers, alphabetical and special characters', 'ascii']]

MODES = [['Normal mode', 'normal'],
        ['Demo mode (no solutions, no database)', 'demo'],
        ['Mass mode (no client response evaluation but highly scalable)', 'mass']]

SPECIAL_CHARS = ["!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ", ", "-", ".", "/", "="]

ALPHA_DOWN = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
ALPHA_CAP  = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
ALPHA = ALPHA_DOWN + ALPHA_CAP

DIGITS    = ['0','1','2','3','4','5','6','7','8','9']

JAVASCRIPTS = ['prototype', 'effects', 'lowpro', 'helper', 'sha256', 'algorithm']

PRESETS = [['client', 'For our own HTML interface'], ['facebook', 'A low-duty version for Facebook profiles']]

solve! # We don't want everything to begin unless via settings