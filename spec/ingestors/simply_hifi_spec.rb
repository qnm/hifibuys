require 'spec_helper'

describe "SimplyHifi" do

  it "should return an item for some example html" do
    VCR.use_cassette('simply_hifi') do
      parser = SimplyHifi.parse open(SimplyHifi._source)
      item = parser.items.first.to_hash
      item[:name].should == "Arcam Solo Neo Special Price $1,600.00 New"
      item[:url].to_s.should == "http://www.simplyhifi.com.au/products-page/specials/arcam-solo-neo/"
      item[:price].should == "$1600"
    end
  end
end
