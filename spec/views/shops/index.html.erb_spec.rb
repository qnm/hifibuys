require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/shops/index.html.erb" do
  include ShopsHelper

  before(:each) do
    assigns[:shops] = [
      stub_model(Shop,
        :name => "value for name",
        :address => "value for address",
        :suburb => "value for suburb",
        :city => "value for city",
        :state => "value for state",
        :country => "value for country"
      ),
      stub_model(Shop,
        :name => "value for name",
        :address => "value for address",
        :suburb => "value for suburb",
        :city => "value for city",
        :state => "value for state",
        :country => "value for country"
      )
    ]
  end

  it "renders a list of shops" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for address".to_s, 2)
    response.should have_tag("tr>td", "value for suburb".to_s, 2)
    response.should have_tag("tr>td", "value for city".to_s, 2)
    response.should have_tag("tr>td", "value for state".to_s, 2)
    response.should have_tag("tr>td", "value for country".to_s, 2)
  end
end
