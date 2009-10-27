require 'rbconfig'
 
class SynchroniserGenerator < Rails::Generator::Base
  attr_reader :file_name, :klass_name
 
  def manifest
    recorded_session = record do |m|
      m.directory 'db/migrate'
      m.template  'create_sync_items.rb', "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_sync_items.rb"
    end
    
    recorded_session
  end

  def after_generate
    puts <<-OUTRO
Now run rake db:migrate to update your database to support the synchroniser
    OUTRO
  end
    
end
