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

  def self.extract(text)
     text.to_s.split(" ") || []
  end

  def self.extract_by_category(text, category)
    self.extract(text).map do |entity|
      entity = self.from_text(entity, category)
      entity.name unless entity.nil?
    end.compact
  end

end
