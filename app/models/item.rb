class Item < ActiveRecord::Base
  acts_as_taggable_on :manufacturers, :types

  def self.search(term, page)
   paginate(:conditions => ["name ILIKE ? ", "%#{term.to_s}%" ],
            :page => page, 
            :per_page => 10, 
            :order => 'created_at DESC' )
  end

  # TODO use an observer instead
  def before_save
    # attempt to associate a manufacturer
    entities = self.name.split(" ") rescue ""
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
  end

  # TODO handle item deletion in tag-land

  # we now add the to_param method which Rails's routing uses
  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end 

  def self.synchronise(items, options = {})
    items.each do |ingestee| 
      key = ingestee.send(options[:key]).to_s
      item = Item.send("find_or_create_by_" + options[:key].to_s, key)
      item.attributes = ingestee.to_hash.merge(:delta => true)

      if item.save
        puts "Saved #{item.name} with id #{item.id}"
      else
        puts "#{item.name} hasnt changed" unless item.id.nil?
      end
    end
  end

end
