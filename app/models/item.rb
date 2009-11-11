class Item < ActiveRecord::Base
  include Synchroniser::Model

  attr_accessor :group

  def item
    url
  end

end
