Omnipopulus.setup do |config|

  # ==> Twitter
  #config.twitter 'kc2DuwBW39Cq6x6iiSLE0A', 'mUJECgERupKymNbOvcVlPithJne3eFOQWw266IN8'

  # ==> Facebook
  #config.facebook '176146695739447', '9bbab3c47499c6bd4c2ee4f4de9420c5', :scope => 'publish_stream'
  
  # ==> GitHub
  # config.github 'APP_KEY', 'APP_SECRET'
  
  # ==> LinkedIn
  # config.linked_in 'APP_KEY', 'APP_SECRET'

  if Rails.env.production?

    # Configs for production mode go here

  elsif Rails.env.development?

    # Configs for development mode go here

  end

end
