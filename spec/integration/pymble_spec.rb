require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Pymble" do

  it "should return an item for some example html" do
    parser = Pymble.parse(open('spec/integration/siteref/pymble.html'))
    item = parser.items.first.to_hash
    item[:name].should == "Parasound 7100"
    item[:description].should == 'Silver'
    item[:url].to_s.should == "http://www.pymblehifi.com.au/parasound-7100"
    #item[:original_price].should == "$14900"
    item[:price].should == "$Call for sale price"
  end
end
