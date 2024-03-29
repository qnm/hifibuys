class Item < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged]

  acts_as_taggable_on :manufacturers, :types
  paginates_per 10

  validates :name, :presence => true
  validates :url, :presence => true

  belongs_to :seller,     :class_name => 'User'
  belongs_to :submitter,  :class_name => 'User'

  def entities
     name.to_s.split(" ") || []
  end

  def manufacturers
    Entity.extract_by_category(name, "manufacturer")
  end

  def types
    Entity.extract_by_category(name, "type")
  end

  def name=(val)
    write_attribute(:name, val.to_s.titleize)
  end
end
