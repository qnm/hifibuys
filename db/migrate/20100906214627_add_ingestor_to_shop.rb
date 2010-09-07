class AddIngestorToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :ingestor, :string
  end

  def self.down
    remove_column :shops, :ingestor
  end
end
