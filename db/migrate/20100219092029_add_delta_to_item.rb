class AddDeltaToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :delta, :boolean, :default => 1
  end

  def self.down
    remove_column :items, :delta
  end
end
