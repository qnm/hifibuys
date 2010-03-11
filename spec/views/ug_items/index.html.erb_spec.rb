require 'spec_helper'

describe "/ug_items/index.html.erb" do
  include UgItemsHelper

  before(:each) do
    assigns[:ug_items] = [
      stub_model(UgItem,
        :name => "value for name",
        :description => "value for description",
        :price => "value for price",
        :url => "value for url",
        :location => "value for location"
      ),
      stub_model(UgItem,
        :name => "value for name",
        :description => "value for description",
        :price => "value for price",
        :url => "value for url",
        :location => "value for location"
      )
    ]
  end

  it "renders a list of ug_items" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for price".to_s, 2)
    response.should have_tag("tr>td", "value for url".to_s, 2)
    response.should have_tag("tr>td", "value for location".to_s, 2)
  end
end
