class RenameItemsUserIdToSubmitterId < ActiveRecord::Migration
  def self.up
    rename_column :items, :user_id,   :submitter_id
    add_column    :items, :seller_id, :integer
  end

  def self.down
    rename_column :items,   :submitter_id, :user_id
    remove_column :items,   :seller_id
  end
end
