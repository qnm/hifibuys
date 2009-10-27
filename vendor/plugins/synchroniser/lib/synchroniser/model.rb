module Synchroniser::Model

  module ClassMethods
    def find_all_flags
      SyncItem.find_all_by_set(self.set)
    end

    def delete_expired_items
      params = {:status => 0,
                :set    => self.set}
      SyncItem.find(:all, :conditions => params).each {|sync_item|
        begin
          eval "#{sync_item.class_name}.find(#{sync_item.id}).delete"
        rescue Exception
          puts "Unable to remove #{sync_item.class_name}.find(#{sync_item.id})"
        end
        sync_item.delete
      }
      puts "Expired Items Deleted"
    end

    def set=(value)
      @@set = value
    end

    def set
      @@set
    end

    def defaults=(value)
      @@defaults = value
    end

    def defaults
      @@defaults
    end


  end

  def before_validation
    if (sync_item = SyncItem.find_by_set_and_item(self.class.set, self.item)).nil? === false
      # we've already sync'd this object
      sync_item.status = 2 
      sync_item.save
      puts "#{sync_item.class_name} with id #{sync_item.class_id} doesn't require an update"
      return false
    end
  end

  def after_save
    # we must have a new object
    sync_item = SyncItem.new({ 
        :set         => self.class.set,
        :item        => self.item,
        :class_name  => self.class.to_s,
        :class_id    => self.id,
        :status      => "1" })
    sync_item.save
    puts "Created new #{sync_item.class_name}"
  end

 def self.included(base)
    base.extend(ClassMethods)
  end

end
