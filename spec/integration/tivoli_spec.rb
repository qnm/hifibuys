require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Tivoli" do

  it "should return an item for some example html" do
    parser = Tivoli.parse open('spec/integration/siteref/tivoli.html')									
    item = parser.items.first.to_hash
    item[:name].should == "Arcam A32 Integrated Amplifier"
    item[:description].should == '100wpc Integrated Current Feedback Amplifier Ultra wide band power amplifier Studio grade electronic volume control Menu driven advanced control...'
    item[:url].to_s.should == "http://tivolihifi.com/store/second-hand-equipment/arcam-a32-integrated-amplifier?zenid=7fd1f1569d0e9e1f1f337f743dc32427"
    item[:price].should == "$1999"
  end
end
