desc "Cron"
task :cron => :environment do

  Rake::Task["db:seed"].execute()

  # regenerate the sitemap
  #Rake::Task["sitemap:refresh"].execute()
end
