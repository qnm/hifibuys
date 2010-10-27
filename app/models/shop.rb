class Shop < ActiveRecord::Base
  def defaults
    { :shop_id      => id,
      :shop_name    => name,
      :shop_address => address,
      :shop_suburb  => suburb,
      :shop_city    => city,
      :shop_state   => state,
      :shop_country => country}
  end

  def filename
    name.downcase.gsub(' ', '_')
  end

  def ingestors
    [ingestor.constantize.parse(open(feed))]
  end

  def ingest
    ingestor.constantize.parse(open(feed)).items
  end

  def item(data)
    Item.new(defaults.merge(data))
  end

end
