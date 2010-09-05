class Shop < ActiveRecord::Base
  def defaults
    { :shop_id      => id,
      :shop_name    => name,
      :shop_address => address,
      :shop_suburb  => suburb,
      :shop_city    => city,
      :shop_state   => state,
      :shop_country => country }
  end

  def filename
    name.downcase.gsub(' ', '_')
  end

  # FIXME: use args here
  def self.normalise(data, name)
    data
  end

end
