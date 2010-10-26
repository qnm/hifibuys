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

  def ingestors
    [ingestor.constantize.parse(open(feed))]
  end

end
