set :stages, %w(staging production)
set :default_stage, "staging"
set(:deploy_to) {"/opt/apps/#{application}/#{stage}"}
require 'capistrano/ext/multistage'
