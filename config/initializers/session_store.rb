# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsite_session',
  :secret      => '9ac5d4d9e9a8acef7f922d384fae3308960cbcbaee68fb60b4e1b8a6249d70fed57dc56fc83bb1e4f707f4d64b6da7732ae0d0a2f54b3db3811e864a69cda536'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
