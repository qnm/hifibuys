class Item < ActiveRecord::Base
  include Synchroniser::Model

  require 'twitter'

  attr_accessor :group
  @@oauth = nil

  def item
    url
  end

  def after_save
    config = YAML::load(File.open(RAILS_ROOT + "/config/twitter.yml"))
    httpauth = Twitter::HTTPAuth.new(config["user"], config["password"])
    client = Twitter::Base.new(httpauth)
    client.update("#{name} for #{price} : #{url}")
puts url
  end

end
