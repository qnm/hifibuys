#set :stages, %w(staging production)
#set :default_stage, "staging"
#set(:deploy_to) {"/opt/apps/#{application}/#{stage}"}
#require 'capistrano/ext/multistage'
server "www.hifibuys.com.au", :app, :web, :db, :primary => true
set :deploy_to, "/opt/apps/hifibuys/production"
