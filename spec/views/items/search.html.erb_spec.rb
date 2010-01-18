require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/search.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:items] = [
      stub_model(Item,
        :name => "value for name",
        :description => "value for description",
        :price => 1,
        :url => "value for url"
      ),
      stub_model(Item,
        :name => "value for name",
        :description => "value for description",
        :price => 1,
        :url => "value for url"
      )
    ]
    assigns[:items].stub!(:total_pages).and_return(1)
  end

  it "renders a list of items" do
    render
    response.should have_tag("h3>a", "value for name".to_s, 2)
    #response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("ul>li[class='price']", 1.to_s, 2)
    #response.should have_tag("h3>a[href='value for url']", "value for name".to_s, 2)
  end
end
