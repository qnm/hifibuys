class CreateSyncItems < ActiveRecord::Migration
  def self.up
    create_table :sync_items, :options => "ENGINE=MyISAM"  do |t|
      t.string :item
      t.string :group
      t.string :class_name
      t.string :class_id
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :sync_items
  end
end
