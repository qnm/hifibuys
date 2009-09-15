class AddCityToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :shop_city, :string
  end

  def self.down
    remove_column :items, :shop_city
  end
end
