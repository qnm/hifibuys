class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string  :name
      t.text    :description
      t.string  :price
      t.string  :url
      t.string  :shop_name
      t.string  :shop_address
      t.string  :shop_suburb
      t.string  :shop_state
      t.string  :shop_country

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end

end
