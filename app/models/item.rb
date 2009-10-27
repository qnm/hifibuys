class Item < ActiveRecord::Base
  include Synchroniser::Model

  def item
    url
  end

end
