class CreateUgItems < ActiveRecord::Migration
  def self.up
    create_table :ug_items do |t|
      t.string :name
      t.text :description
      t.string :price
      t.string :url
      t.string :location
      t.boolean :import, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :ug_items
  end
end
