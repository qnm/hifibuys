# app/views/posts/index.rss.builder
xml.channel do
  # Feed basics.
  xml.title             "Hifibuy Special"
  xml.description       "Cheap but awesome hifi"
  xml.link              "http://www.hifibuys.com.au"
  
  @items.each do |item|
    xml.item do
      xml.title         item.name
      xml.description   item.description
      xml.g             :price, item.price
      xml.link          item.url
      xml.g             :condition, 'new'
      xml.g             :id, item.id
      xml.c             :manufacturer, item.manufacturer_list.to_s
    end
  end
end
