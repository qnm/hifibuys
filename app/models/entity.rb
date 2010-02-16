class Entity < ActiveRecord::Base

  def self.search(term, category)
    self.find( :all, 
      :conditions => ["MATCH (name) AGAINST (? IN BOOLEAN MODE) AND category = ?", '+' + term.to_s, category.to_s ],
      :order => 'created_at DESC' )
  end

end
