class ItemObserver < ActiveRecord::Observer
  def before_save(item)
    # attempt to associate a manufacturer
    entities = item.name.split(" ") rescue ""

    entities.each do |entity|
      entity = Entity.search(entity, "manufacturer").first
      if entity.nil? == false
        item.manufacturer_list = entity.name
      end
    end

    # attempt to associate a type
    entities.each do |entity|
      entity = Entity.search(entity, "type").first
      if entity.nil? == false
        item.type_list = entity.name
      end
    end
  end

end
