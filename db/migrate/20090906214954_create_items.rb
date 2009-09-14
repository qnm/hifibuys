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
    execute 'ALTER TABLE items ENGINE = MyISAM'
    execute 'CREATE FULLTEXT INDEX fulltext_search ON items (name, description, shop_state, shop_suburb)'
  end

  def self.down
    execute 'ALTER TABLE items ENGINE = InnoDB'
    execute 'DROP INDEX fulltext_search ON items'
    drop_table :items
  end

end
