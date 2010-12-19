class DeleteUgItems < ActiveRecord::Migration
  def self.up
    drop_table :ug_items
  end

  def self.down
  end
end
