class Item < ActiveRecord::Base
  include Synchroniser::Model
  acts_as_taggable_on :manufacturers

  require 'twitter'

  attr_accessor :group

  def item
    url
  end

  def before_save
    # attempt to associate a manufacturer
    entity = Entity.search(self.name).first
    if entity.nil? == false
      self.manufacturer_list = entity.name
    end
    super
  end


  def after_save
    #config = YAML::load(File.open(RAILS_ROOT + "/config/twitter.yml"))
    #httpauth = Twitter::HTTPAuth.new(config["user"], config["password"])
    #client = Twitter::Base.new(httpauth)
    #client.update("#{name} for #{price} : #{url}")
    super
  end

end
