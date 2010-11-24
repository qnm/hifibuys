class Item < ActiveRecord::Base
  acts_as_taggable_on :manufacturers, :types
  has_friendly_id :name, :use_slug => true
  validates :name, :presence => true 

  def self.search(term, page)
   paginate(:conditions => ["name ILIKE ? ", "%#{term.to_s}%" ],
            :page => page, 
            :per_page => 10, 
            :order => 'created_at DESC' )
  end

end
