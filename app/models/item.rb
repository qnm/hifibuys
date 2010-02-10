class Item < ActiveRecord::Base
  include Synchroniser::Model

  require 'twitter'

  attr_accessor :group

  belongs_to  :manufacturer
  accepts_nested_attributes_for :manufacturer


  def item
    url
  end


  def before_save
    # attempt to associate a manufacturer
    manufacturer = Manufacturer.search(self.name)
    if manufacturer.nil? == false
      self.manufacturer = manufacturer.first
    end
  end

  def after_save
    #config = YAML::load(File.open(RAILS_ROOT + "/config/twitter.yml"))
    #httpauth = Twitter::HTTPAuth.new(config["user"], config["password"])
    #client = Twitter::Base.new(httpauth)
    #client.update("#{name} for #{price} : #{url}")
    super
  end

end
