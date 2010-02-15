class Entity < ActiveRecord::Base

  def self.search(term)
    self.find( :all, 
      :conditions => ["MATCH (name) AGAINST (? IN BOOLEAN MODE)", '+' + term.to_s ],
      :order => 'created_at DESC' )
  end

end
