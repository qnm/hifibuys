require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/shops/show.html.erb" do
  include ShopsHelper
  before(:each) do
    assigns[:shop] = @shop = stub_model(Shop,
      :name => "value for name",
      :address => "value for address",
      :suburb => "value for suburb",
      :city => "value for city",
      :state => "value for state",
      :country => "value for country"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ address/)
    response.should have_text(/value\ for\ suburb/)
    response.should have_text(/value\ for\ city/)
    response.should have_text(/value\ for\ state/)
    response.should have_text(/value\ for\ country/)
  end
end
