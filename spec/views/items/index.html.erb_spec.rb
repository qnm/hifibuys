require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/index.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:items] = [
      stub_model(Item,
        :name => "value for name",
        :description => "value for description",
        :price => "value for price",
        :url => "value for url",
        :shop_name => "value for shop_name",
        :shop_address => "value for shop_address",
        :shop_suburb => "value for shop_suburb",
        :shop_state => "value for shop_state",
        :shop_country => "value for shop_country"
      ),
      stub_model(Item,
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
    ]
  end

  it "renders a list of items" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for price".to_s, 2)
    response.should have_tag("tr>td", "value for url".to_s, 2)
    response.should have_tag("tr>td", "value for shop_name".to_s, 2)
    response.should have_tag("tr>td", "value for shop_address".to_s, 2)
    response.should have_tag("tr>td", "value for shop_suburb".to_s, 2)
    response.should have_tag("tr>td", "value for shop_state".to_s, 2)
    response.should have_tag("tr>td", "value for shop_country".to_s, 2)
  end
end
