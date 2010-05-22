desc "Cron"
task :cron => :environment do
  name = 'audio_connection'
  Rake::Task["synchroniser:provider"].execute(name)

  name = 'tivoli'
  Rake::Task["synchroniser:provider"].execute(name)

  name = 'carlton'
  Rake::Task["synchroniser:provider"].execute(name)
end
