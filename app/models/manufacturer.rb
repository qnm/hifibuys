class Manufacturer < ActiveRecord::Base
  has_many :items

  def self.search(term)
    self.find( :all, 
      :conditions => ["MATCH (name) AGAINST (? IN NATURAL LANGUAGE MODE)", '+' + term ],
      :order => 'created_at DESC' )
  end

end
