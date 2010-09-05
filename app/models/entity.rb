class Entity < ActiveRecord::Base

  def self.search(term, category)
    self.find( :all, 
      :conditions => ["name ILIKE ? AND category = ?", '%' + term.to_s + '%', category.to_s ],
      :order => 'created_at DESC' )
  end

  #FIXME: Use args here
  def self.normalise(data, name)
    data.inject([]) do |store, entity| 
      store << {:category => name.singularize, :name => entity}
    end
  end

end
