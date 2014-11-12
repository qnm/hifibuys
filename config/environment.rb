# Load the rails application
require File.expand_path('../application', __FILE__)

if Rails.env.development?
  Rails.logger = Le.new('303c2062-208b-4398-b41d-d7bb4feabe72', debug: true)
else
  Rails.logger = Le.new('303c2062-208b-4398-b41d-d7bb4feabe72')
end

# Initialize the rails application
Hifibuys::Application.initialize!
