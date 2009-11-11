class YqlOpendatatableIngestor
  require File.join(RAILS_ROOT, 'vendor', 'plugins', 'synchroniser', 'lib', 'synchroniser', 'ingestor', 'yql.rb')
  include Synchroniser::Ingestor::Yql

  def ingest(container)
    @data.collect {|@current_item| 
      itemise(item, container.clone)
    }
  end

  def itemise(item, container)
    container.instance_eval{
      self.name         = item['name']
      self.description  = item['description']
      self.url          = item['url']
      self.price        = @item['price']
      self 
    }
  end

end
