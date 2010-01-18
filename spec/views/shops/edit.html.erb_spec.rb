require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/shops/edit.html.erb" do
  include ShopsHelper

  before(:each) do
    assigns[:shop] = @shop = stub_model(Shop,
      :new_record? => false,
      :name => "value for name",
      :address => "value for address",
      :suburb => "value for suburb",
      :city => "value for city",
      :state => "value for state",
      :country => "value for country"
    )
  end

  it "renders the edit shop form" do
    render

    response.should have_tag("form[action=#{shop_path(@shop)}][method=post]") do
      with_tag('input#shop_name[name=?]', "shop[name]")
      with_tag('input#shop_address[name=?]', "shop[address]")
      with_tag('input#shop_suburb[name=?]', "shop[suburb]")
      with_tag('input#shop_city[name=?]', "shop[city]")
      with_tag('input#shop_state[name=?]', "shop[state]")
      with_tag('input#shop_country[name=?]', "shop[country]")
    end
  end
end
