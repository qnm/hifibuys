class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :suburb
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :shops
  end
end
