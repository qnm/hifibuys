class ItemObserver < ActiveRecord::Observer
  def before_save(item)
    item.manufacturer_list = item.manufacturers
    item.type_list = item.types
  end
end
