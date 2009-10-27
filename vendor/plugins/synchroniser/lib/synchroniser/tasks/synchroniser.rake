require 'yaml'

namespace :synchroniser do

  desc "Ingest a provider"
  task :provider => :environment do  |t, args|
  config = YAML::load(File.open("#{RAILS_ROOT}/config/ingestors.yml"))
  params = config[RAILS_ENV][args.name]['params']
  ingestor = config[RAILS_ENV][args.name]['ingestor']

  require ingestor + "_ingestor.rb"
  params['url'].each { |url|
    strategy = eval ingestor.camelize + "Ingestor.new(params, url, args.name)"
    strategy.sync
  }
  end
end
