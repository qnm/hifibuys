class UgItemIngestor
  include Synchroniser::Ingestor


  def load(url)
    true
  end

  def ingest(container)
    UgItem.find_all_by_import(true).to_a.collect {|item|
      itemise(item, container.clone) 
    }
  end

  def itemise(item, container)
    thing = container.instance_eval{
      self.name         = item.name
      self.description  = item.description
      self.url          = item.url
      self.price        = item.price
      self.shop_name    = item.location
      self
    }
  end

end
