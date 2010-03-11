require 'spec_helper'
require 'ug_item_ingestor'

describe UgItemsHelper do

  before(:each) do


    @ug_item_not_imported = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :location => "value for location",
      :import => true
    }

    @ug_item_not_imported_b = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url part deux",
      :location => "value for location",
      :import => true
    }

    @ug_item_not_imported_c = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url part trois",
      :location => "value for location",
      :import => true
    }

    @item_not_imported = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :location => "value for location",
      :import => true
    }

    @ug_item_imported = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :location => "value for location",
      :import => false
    }

  end

  #Delete this example and add some real ones or delete this file
  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(UgItemsHelper)
  end

  it "should itemise ug_item to item" do
    @ug_item = UgItem.create!(@ug_item_not_imported)
    @ingestor = UgItemIngestor.new
    @item = @ingestor.itemise(@ug_item, Item.new)

    @item.name.should equal(@ug_item.name) 
    @item.description.should equal(@ug_item.description) 
    @item.url.should equal(@ug_item.url) 
    @item.price.should equal(@ug_item.price) 
    @item.shop_name.should equal(@ug_item.location) 
  end

  it "should not ingest items that do not require import" do
    UgItem.create!(@ug_item_imported)
    @ingestor = UgItemIngestor.new
    @items = @ingestor.ingest(Item.new)
    @items.length.should == 0
  end

  it "should ingest a single item that require import" do
    UgItem.create!(@ug_item_not_imported)
    @ingestor = UgItemIngestor.new
    @items = @ingestor.ingest(Item.new)
    @items.length.should == 1
  end

  it "should ingest items that require import" do
    a = UgItem.create!(@ug_item_not_imported_b)
    b = UgItem.create!(@ug_item_not_imported_c)
    @ingestor = UgItemIngestor.new
    @items = @ingestor.ingest(Item.new)
    @items.length.should == 2
  end

end
