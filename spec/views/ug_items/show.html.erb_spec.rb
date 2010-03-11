require 'spec_helper'

describe "/ug_items/show.html.erb" do
  include UgItemsHelper
  before(:each) do
    assigns[:ug_item] = @ug_item = stub_model(UgItem,
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :location => "value for location"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ price/)
    response.should have_text(/value\ for\ url/)
    response.should have_text(/value\ for\ location/)
  end
end
