# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shacker_session',
  :secret      => 'f5b8123315f7aab09252cd393859eaa984d9661af748af2a64977946c044677b90febf52a2818d8bdb24979aa453c1bd407fb961de7594c27fdb41a35a19e270'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
