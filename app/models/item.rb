class Item < ActiveRecord::Base
  include Synchroniser::Model
  acts_as_taggable_on :manufacturers, :types

  # this model is sitemappable
  sitemap

  require 'twitter'

  def item
    url
  end

  def before_save
    # attempt to associate a manufacturer
    entities = self.name.split(" ")
    entities.each do |entity|
      entity = Entity.search(entity, "manufacturer").first
      if entity.nil? == false
        self.manufacturer_list = entity.name
      end
    end

    # attempt to associate a type
    entities.each do |entity|
      entity = Entity.search(entity, "type").first
      if entity.nil? == false
        self.type_list = entity.name
      end
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

  # we now add the to_param method which Rails's routing uses
  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end 

end
