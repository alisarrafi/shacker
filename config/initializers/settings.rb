SETTINGS_FILE = File.join Rails.root, 'config', 'settings.yml'
SOLUTION_FILE = File.join Rails.root, 'tmp', 'solution.txt'

MODES = [['Only alphabetical characters', 'alpha'],
        ['Alphabetical characters and numbers', 'alnum'],
        ['Only numbers', 'digit'],
        ['Numbers, alphabetical and special characters', 'ascii']]

SPECIAL_CHARS = ["!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ", ", "-", ".", "/", "="]

ALPHA_DOWN = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
ALPHA_CAP  = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
ALPHA = ALPHA_DOWN + ALPHA_CAP

DIGITS    = ['0','1','2','3','4','5','6','7','8','9']

