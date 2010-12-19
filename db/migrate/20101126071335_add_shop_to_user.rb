class AddShopToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nickname, :string
    add_column :users, :address, :string
    add_column :users, :suburb, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
  end

  def self.down
    remove_column :users, :country
    remove_column :users, :state
    remove_column :users, :city
    remove_column :users, :suburb
    remove_column :users, :address
    remove_column :users, :nickname
  end
end
