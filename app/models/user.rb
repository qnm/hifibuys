class User < ActiveRecord::Base #Omnipopulus::User
  has_many  :items
  # Make any customisations here
end
