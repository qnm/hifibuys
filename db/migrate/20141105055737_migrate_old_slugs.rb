class MigrateOldSlugs < ActiveRecord::Migration
  def change
    Item.all.map(&:save)
  end
end
