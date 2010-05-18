class AddDeltaToEntity < ActiveRecord::Migration
  def self.up
    add_column :entities, :delta, :boolean, :default => true
  end

  def self.down
    remove_column :entities, :delta
  end
end
