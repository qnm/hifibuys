class Item < ActiveRecord::Base
  acts_as_taggable_on :manufacturers, :types

  validates :name, :presence => true 

  def self.search(term, page)
   paginate(:conditions => ["name ILIKE ? ", "%#{term.to_s}%" ],
            :page => page, 
            :per_page => 10, 
            :order => 'created_at DESC' )
  end

  # we now add the to_param method which Rails's routing uses
  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end 

  def self.synchronise(items, options = {})
    items.inject([]) do |items, ingestee| 
      key = ingestee.send(options[:key]).to_s
      item = Item.send("find_or_create_by_" + options[:key].to_s, key)
      item.attributes = ingestee.to_hash.merge(:delta => true)
      items << item
    end
  end

end
