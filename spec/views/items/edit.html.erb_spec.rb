require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/edit.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description",
      :price => 1,
      :url => "value for url"
    )
  end

  it "renders the edit item form" do
    render

    response.should have_tag("form[action=#{item_path(@item)}][method=post]") do
      with_tag('input#item_name[name=?]', "item[name]")
      with_tag('textarea#item_description[name=?]', "item[description]")
      with_tag('input#item_price[name=?]', "item[price]")
      with_tag('input#item_url[name=?]', "item[url]")
    end
  end
end
