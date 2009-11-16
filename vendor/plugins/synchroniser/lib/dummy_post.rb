class DummyPost
  include Synchroniser::Model

  attr_accessor :title
  attr_accessor :url
  attr_accessor :group
  attr_accessor :test_default

  def initialize(values)
    @title   = values[:title]
    @url    = values[:url]
  end

  def save
    puts @title
    puts @url
  end

  def item
    url
  end

end
