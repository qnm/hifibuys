class AddShopHashToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :shop_hash, :string
  end

  def self.down
    remove_column :items, :shop_hash
  end
end
