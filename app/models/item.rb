class Item < ActiveRecord::Base
  acts_as_taggable_on :manufacturers, :types
  has_friendly_id :name, :use_slug => true

  validates :name, :presence => true 
  validates :url, :presence => true 

  belongs_to :seller,     :class_name => 'User'
  belongs_to :submitter,  :class_name => 'User'

  def entities
     name.to_s.split(" ") || []
  end

  def image_url=(moo)
    nil
  end
end
