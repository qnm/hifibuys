# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hifibuys_session',
  :secret      => '42c699ab2653ccca846809f8d8520dc562a832d8a0dcabdf41a29bd7d0d562c6820bdc83efb9b344c6a87f1b6effe88ee75d5147d14d946c19767a422fed295f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
