task :update_items do
  Rake::Task['db:seed'].execute
end
