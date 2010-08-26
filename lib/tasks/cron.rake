desc "Cron"
task :cron => :environment do

  ["audio_connection", "tivoli", "carlton_audio_visual"].each do |provider|
    Rake::Task["synchroniser:provider"].execute({"name" => provider})
  end

  # regenerate the sitemap
  #Rake::Task["sitemap:refresh"].execute()
end
