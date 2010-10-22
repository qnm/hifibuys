require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AudioConnection" do

  it "should return an item for some example html" do
    parser = AudioConnection.parse open('spec/integration/siteref/audioconnection.html')										
    item = parser.items.first
    item.name.should == "Schroers &amp; Schroers Lambda TV mini stand"
    item.description.should == ''
    item.url.to_s.should == "http://www.audioconnection.com.au/products/lambda-tv-mini-stand.asp"
    item.price.should == "$600.00"
  end
end
