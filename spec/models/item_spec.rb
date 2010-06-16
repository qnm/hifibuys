require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Item do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :shop_name => "value for shop_name",
      :shop_address => "value for shop_address",
      :shop_suburb => "value for shop_suburb",
      :shop_state => "value for shop_state",
      :shop_country => "value for shop_country",
      :group => "nogroup"
    }

    @valid_attributes_b = {
      :name => "test_manufacturer test_type",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url2",
      :shop_name => "value for shop_name",
      :shop_address => "value for shop_address",
      :shop_suburb => "value for shop_suburb",
      :shop_state => "value for shop_state",
      :shop_country => "value for shop_country",
      :group => "nogroup"
    }

  end

  it "should create a new instance given valid attributes" do
    Item.create!(@valid_attributes)
  end

  it "should create a manufacturers tag if an entity matches" do
    Entity.create!(:name => "test_manufacturer", :category => "manufacturer")

    @item = Item.create!(@valid_attributes_b)
    @item.manufacturers.first.name.should == "test_manufacturer"
  end

  it "should create a type tag if an entity matches" do
    Entity.create!(:name => "test_type", :category => "type")

    @item = Item.create!(@valid_attributes_b)
    @item.types.first.name.should == "test_type"
  end

  it "should return an exact match search" do
    @item = Item.create!(@valid_attributes_b)

    Item.search(@valid_attributes_b[:name], 1).first.name.should == @valid_attributes_b[:name]
  end

  it "should return a case insensitive match search" do
    @item = Item.create!(@valid_attributes_b)

    Item.search(@valid_attributes_b[:name].swapcase, 1).first.name.should == @valid_attributes_b[:name]
  end

end
