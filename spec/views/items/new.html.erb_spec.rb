require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/new.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = stub_model(Item,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :price => 1,
      :url => "value for url"
    )
  end

  it "renders new item form" do
    render

    response.should have_tag("form[action=?][method=post]", items_path) do
      with_tag("input#item_name[name=?]", "item[name]")
      with_tag("textarea#item_description[name=?]", "item[description]")
      with_tag("input#item_price[name=?]", "item[price]")
      with_tag("input#item_url[name=?]", "item[url]")
    end
  end
end
