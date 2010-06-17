desc "Cron"
task :cron => :environment do

  # audio connection provider
  name = 'audio_connection'
  Rake::Task["synchroniser:provider"].execute(name)

  # tivoli provider
  name = 'tivoli'
  Rake::Task["synchroniser:provider"].execute(name)

  # carlton provider
  name = 'carlton'
  Rake::Task["synchroniser:provider"].execute(name)

  # regenerate the sitemap
  Rake::Task["sitemap:generate"].execute()
end
