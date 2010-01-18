require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Shop do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :address => "value for address",
      :suburb => "value for suburb",
      :city => "value for city",
      :state => "value for state",
      :country => "value for country"
    }
  end

  it "should create a new instance given valid attributes" do
    Shop.create!(@valid_attributes)
  end
end
