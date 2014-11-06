source 'http://rubygems.org'

ruby '2.1.2'
gem 'rails', '4.1.7'
gem 'rails-observers'
gem 'protected_attributes'
gem "omniauth"
#gem 'omnipopulus'
gem 'devise'
gem "haml-rails"
gem "pg"
gem 'nibbler'
gem "acts-as-taggable-on"
gem 'kaminari'
gem "friendly_id", "~> 5.0.1"
#gem 'omnipopulus'
gem 'sanitize'
gem 'babosa'
gem 'ransack'
gem 'cells'
gem "twitter-bootstrap-rails"
gem 'jquery-rails', '~> 2.1'
gem 'simple_form'
gem 'apotomo'
gem 'masonry-rails'
gem 'yaml_db'
gem 'newrelic_rpm'
gem 'turbo-sprockets-rails3'
gem 'foreman'
gem 'puma', '=2.8.1'
gem 'rack', '=1.5.2'
gem 'rollbar', '~> 1.2.6'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'execjs'
end

group :development, :test do
  gem 'faraday'
  gem 'heroku'
  gem 'taps'
  gem 'fakeweb'
  gem 'vcr'
  gem 'faker'
  gem 'machinist'
  gem 'guard-rspec'
  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
  gem 'guard'
  gem "rspec-rails"
  gem 'activerecord-nulldb-adapter', '~> 0.3.1'
  gem 'rspec-apotomo'
  gem 'capybara'
  #gem 'guard-livereload'
  gem 'rb-fsevent', '0.9.3', require: RUBY_PLATFORM.include?('darwin') && 'rb-fsevent'
end
