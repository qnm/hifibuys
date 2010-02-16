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
      :shop_country => "value for shop_country"
    }

    @valid_attributes_b = {
      :name => "test_manufacturer",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url2",
      :shop_name => "value for shop_name",
      :shop_address => "value for shop_address",
      :shop_suburb => "value for shop_suburb",
      :shop_state => "value for shop_state",
      :shop_country => "value for shop_country"
    }

  end

  it "should create a new instance given valid attributes" do
    Item.create!(@valid_attributes)
  end

  it "should create a manufacturers tag if an entity matches" do
    Entity.create!(:name => "test_manufacturer", :category => "manufacturer")

    @item = Item.create!(@valid_attributes_b)
    @item.manufacturers.first.name == "test manufacturer"
  end
end
