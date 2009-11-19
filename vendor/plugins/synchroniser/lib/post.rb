class Post < ActiveRecord::Base
  include Synchroniser::Model

  attr_accessor :test_default

  def item
    url
  end

end

