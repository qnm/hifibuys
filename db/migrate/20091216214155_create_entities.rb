class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
    execute 'ALTER TABLE entities ENGINE = MyISAM'
    execute 'CREATE FULLTEXT INDEX fulltext_search ON entities (name)'
  end

  def self.down
    execute 'ALTER TABLE entities ENGINE = InnoDB'
    execute 'DROP INDEX fulltext_search ON entities'
    drop_table :entities
  end
end
