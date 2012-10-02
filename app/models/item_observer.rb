class ItemObserver < ActiveRecord::Observer
  def before_save(item)

    item.entities.each do |entity|
      entity = Entity.from_text(entity, "manufacturer")
      item.manufacturer_list = entity.name unless entity.nil?
    end

    # attempt to associate a type
    item.entities.each do |entity|
      entity = Entity.from_text(entity, "type")
      item.type_list = entity.name unless entity.nil?
    end
  end

end
