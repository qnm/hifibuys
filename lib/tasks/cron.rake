desc "Cron"
task :cron => :environment do
  name = 'audio_connection'
  Rake::Task["synchroniser:provider"].invoke(name)
end
