require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Pymble" do

  it "should return an item for some example html" do
    VCR.use_cassette('pymble') do
      parser = Pymble.parse open(Pymble._source)
      item = parser.items.first.to_hash
      item[:name].should == "MA9S2 x 2"
      item[:description].should == 'Gold'
      item[:url].to_s.should == "http://www.pymblehifi.com.au/ma9s2-x-2"
      item[:original_price].should == "$14900"
      item[:price].should == "$11000"
    end
  end
end
