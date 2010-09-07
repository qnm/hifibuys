class Shop < ActiveRecord::Base
  def defaults
    { :shop_id      => id,
      :shop_name    => name,
      :shop_address => address,
      :shop_suburb  => suburb,
      :shop_city    => city,
      :shop_state   => state,
      :shop_country => country,
      :group        => ingestor}
  end

  def filename
    name.downcase.gsub(' ', '_')
  end

  # FIXME: use args here
  def self.normalise(data, name)
    data
  end

  def ingestors
    my_ingestor = Module.const_get(ingestor).new
    my_ingestor.strategise(feed)
  end

end
