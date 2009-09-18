require 'yaml'

namespace :ingest do
  desc "Ingest a provider"
  task :provider => :environment do  |t, args|
    config = YAML::load(File.open("#{RAILS_ROOT}/config/ingestors.yml"))
    params = config[RAILS_ENV][args.name]['params']
    shop = config[RAILS_ENV][args.name]['shop']
    ingestor = config[RAILS_ENV][args.name]['ingestor']

    require ingestor + "_ingestor.rb"
    params['url'].each { |url|
      strategy = eval ingestor.camelize + "Ingestor.new(params, url)"
      strategy.wipe
      strategy.ingest.each { |item|
        puts item
        item.save
        puts "Added!"
      }
    }
  end
end
