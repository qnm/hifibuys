require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/edit.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :new_record? => false,
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

  it "renders the edit item form" do
    render

    response.should have_tag("form[action=#{item_path(@item)}][method=post]") do
      with_tag('input#item_name[name=?]', "item[name]")
      with_tag('textarea#item_description[name=?]', "item[description]")
      with_tag('input#item_price[name=?]', "item[price]")
      with_tag('input#item_url[name=?]', "item[url]")
      with_tag('input#item_shop_name[name=?]', "item[shop_name]")
      with_tag('input#item_shop_address[name=?]', "item[shop_address]")
      with_tag('input#item_shop_suburb[name=?]', "item[shop_suburb]")
      with_tag('input#item_shop_state[name=?]', "item[shop_state]")
      with_tag('input#item_shop_country[name=?]', "item[shop_country]")
    end
  end
end
