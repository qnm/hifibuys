class AddOriginalPriceToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :original_price, :string
  end

  def self.down
    remove_column :items, :original_price
  end
end
