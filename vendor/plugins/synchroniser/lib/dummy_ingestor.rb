class DummyIngestor
  include Synchroniser::Ingestor::Uri

  attr_accessor :data

  def initialize
    @data = [ 
              { :url => "abc123", :title => "123abc" },
              { :url => "def456", :title => "def456" }
            ]
  end

  def ingest(container)
    @data.map {|item|
      itemise(item, container.clone) 
    }
  end

  def itemise(item, container)
    container.instance_eval{
      self.url = item[:url]
      self.title = item[:title]
      self
    }
  end

end
