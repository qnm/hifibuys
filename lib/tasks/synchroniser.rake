require 'yaml'

namespace :synchroniser do

  desc "Ingest a provider"
  task :provider, [:name] => [:environment] do  |t, args|
    if args.name.nil?
      raise ArgumentError, "name argument must be supplied to the rake task"
    end

    synchroniser = Synchroniser::Config::Params.new("/config/ingestors.yml", args.name).get_sync
    synchroniser.sync
  end
end
