class ItemObserver < ActiveRecord::Observer
  def before_save(item)
    # attempt to associate a manufacturer
    entities = item.name.split(" ") rescue ""

    entities.each do |entity|
      entity = Entity.name_like(entity).category_like("manufacturer").first
      if entity.nil? == false
        item.manufacturer_list = entity.name
      end
    end

    # attempt to associate a type
    entities.each do |entity|
      entity = Entity.name_like(entity).category_like("type").first
      if entity.nil? == false
        item.type_list = entity.name
      end
    end
  end

end
