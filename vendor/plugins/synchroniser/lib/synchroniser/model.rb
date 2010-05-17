module Synchroniser::Model
  require File.join(File.dirname(__FILE__), '..', 'sync_item.rb')

  def find_all_flags
    SyncItem.find_all_by_group(group)
  end

  def delete_expired_items
    params = {:status => false,
              :group    => group}
    SyncItem.find(:all, :conditions => params).each {|sync_item|
      begin
        eval "#{sync_item.class_name}.find(#{sync_item.id}).delete"
      rescue Exception
        SyncItem.logger.warn("Unable to remove #{sync_item.class_name}.find(#{sync_item.id})")
      end
      sync_item.delete
    }
    SyncItem.logger.info("Expired Items Deleted")
  end

  def before_validation
    if (sync_item = SyncItem.find_by_group_and_item(group, self.item)).nil? === false
      # we've already sync'd this object
      sync_item.status = 2 
      sync_item.save
      SyncItem.logger.info("#{sync_item.class_name} with id #{sync_item.class_id} doesn't require an update")
      #stop further saving
      #TODO on innodb tables this will cause the transaction to rollback
      return false
    end
    return true
  end

  def after_save
    # we must have a new object
    sync_item = SyncItem.new({ 
        :group       => group,
        :item        => self.item,
        :class_name  => self.class.to_s,
        :class_id    => self.id,
        :status      => "1" })
    sync_item.save
    SyncItem.logger.info("Created new #{sync_item.class_name}")
  end

  def group=(value)
    @@group = value
  end

  def group
    @@group
  end

end
