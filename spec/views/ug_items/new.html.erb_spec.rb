require 'spec_helper'

describe "/ug_items/new.html.erb" do
  include UgItemsHelper

  before(:each) do
    assigns[:ug_item] = stub_model(UgItem,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :location => "value for location"
    )
  end

  it "renders new ug_item form" do
    render

    response.should have_tag("form[action=?][method=post]", ug_items_path) do
      with_tag("input#ug_item_name[name=?]", "ug_item[name]")
      with_tag("textarea#ug_item_description[name=?]", "ug_item[description]")
      with_tag("input#ug_item_price[name=?]", "ug_item[price]")
      with_tag("input#ug_item_url[name=?]", "ug_item[url]")
      with_tag("input#ug_item_location[name=?]", "ug_item[location]")
    end
  end
end
