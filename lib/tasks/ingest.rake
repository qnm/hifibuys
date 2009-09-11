require 'yaml'

namespace :ingest do
  desc "Ingest a provider"
  task :provider => :environment do  |t, args|
    config = YAML::load(File.open("#{RAILS_ROOT}/config/ingestors.yml"))
    params = config[RAILS_ENV][args.name]['params']
    ingestor = config[RAILS_ENV][args.name]['ingestor']

    require ingestor + "_ingestor.rb"
    strategy = eval ingestor.camelize + "Ingestor.new(params)"

    strategy.ingest.each { |item|
      puts item.save
    }
  end
end
