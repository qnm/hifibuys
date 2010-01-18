class AddFeedToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :feed, :string
  end

  def self.down
    remove_column :shops, :feed
  end
end
