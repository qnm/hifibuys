require 'spec_helper'

describe UgItem do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :price => "value for price",
      :url => "value for url",
      :location => "value for location"
    }
  end

  it "should create a new instance given valid attributes" do
    UgItem.create!(@valid_attributes)
  end
end
