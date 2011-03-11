class Item < ActiveRecord::Base
  acts_as_taggable_on :manufacturers, :types
  has_friendly_id :name, :use_slug => true
  validates :name, :presence => true 

  belongs_to :seller,     :class_name => 'User'
  belongs_to :submitter,  :class_name => 'User'
end
