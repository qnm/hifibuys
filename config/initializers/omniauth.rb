=begin
Rails.application.config.middleware.use OmniAuth::Builder do
  # Set up your authentication providers here.
  # Once you've done that you will need to set up a
  # route that handles /auth/:provider/callback
  # and takes a look at request.env['omniauth.auth']
  # for authentication information.
  #
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :open_id, OpenID::Storage::Filesystem.new('/tmp')
end
=end
