class CreateItemsDrop < ActiveRecord::Migration
  def self.up
    drop_table :items
  end

  def self.down
  end

end
