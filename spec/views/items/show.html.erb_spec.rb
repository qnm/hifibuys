require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/show.html.erb" do
  include ItemsHelper
  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :shop_name => "value for shop_name",
      :shop_address => "value for shop_address",
      :shop_suburb => "value for shop_suburb",
      :shop_state => "value for shop_state",
      :shop_country => "value for shop_country"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ price/)
    response.should have_text(/value\ for\ shop_name/)
    response.should have_text(/value\ for\ shop_address/)
    response.should have_text(/value\ for\ shop_suburb/)
    response.should have_text(/value\ for\ shop_state/)
    response.should have_text(/value\ for\ shop_country/)
  end
end
