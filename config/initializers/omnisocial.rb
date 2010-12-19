Omnisocial.setup do |config|
  
  # ==> Twitter
  config.twitter 'kc2DuwBW39Cq6x6iiSLE0A', 'mUJECgERupKymNbOvcVlPithJne3eFOQWw266IN8'
  
  # ==> Facebook
  config.facebook 'APP_KEY', 'APP_SECRET', :scope => 'publish_stream'
  
  if Rails.env.production?
    
    # Configs for production mode go here
    
  elsif Rails.env.development?
    
    # Configs for development mode go here
    
  end
  
end
