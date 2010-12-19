class RemoveShopDataFromItems < ActiveRecord::Migration
  def self.up
    remove_column :items, :shop_id
    remove_column :items, :shop_state
    remove_column :items, :shop_country
    remove_column :items, :shop_address
    remove_column :items, :shop_suburb
    remove_column :items, :shop_hash
    remove_column :items, :shop_name
    remove_column :items, :shop_city
  end

  def self.down
    add_column :items, :shop_id,       :integer
    add_column :items, :shop_state,    :string
    add_column :items, :shop_country,  :string
    add_column :items, :shop_address,  :string
    add_column :items, :shop_suburb,   :string
    add_column :items, :shop_hash,     :string
    add_column :items, :shop_name,     :string
    add_column :items, :shop_city,     :string
  end
end
