class Entity < ActiveRecord::Base
  def self.name_like(name)
    return self if name.nil?

    t = self.arel_table
    where(t[:name].matches("#{name}%"))
  end

  def self.category_like(category)
    return self if category.nil?

    t = self.arel_table
    where(t[:category].matches("#{category}%"))
  end

  def self.from_text(entity, type=nil)
    self.name_like(entity).category_like(type).first
  end

end
