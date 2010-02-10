class CreateManufacturers < ActiveRecord::Migration
  def self.up
    create_table :manufacturers do |t|
      t.string :name
      t.integer :status

      t.timestamps
    end
    execute 'ALTER TABLE manufacturers ENGINE = MyISAM'
    execute 'CREATE FULLTEXT INDEX fulltext_search ON manufacturers (name)'
  end

  def self.down
    execute 'ALTER TABLE manufacturers ENGINE = InnoDB'
    execute 'DROP INDEX fulltext_search ON manufacturers'
    drop_table :manufacturers
  end
end
