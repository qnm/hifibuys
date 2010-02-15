class Item < ActiveRecord::Base
  #include Synchroniser::Model

  require 'twitter'

  attr_accessor :group

  def item
    url
  end


  def before_save
    # attempt to associate a manufacturer
    #manufacturer = Manufacturer.search(self.name).first
    #if manufacturer.nil? == false
      #self.manufacturer = manufacturer

      #tag the manufacturer as being in use
      #self.manufacturer.status = 1
      #self.manufacturer.save
    #end
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
