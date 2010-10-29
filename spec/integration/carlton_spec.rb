require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Carlton" do

  it "should return an item for some example html" do
    parser = Carlton.parse open('spec/integration/siteref/carlton.html')									
    item = parser.items[1].to_hash
    item[:name].should == "Denon AVR1509"
    item[:description].should == 'The entry point for Denon Receivers for 2009 this retains that particularly good stereo sound and high quality construction that is the hallmark of all of this product family. If only a consumer were able to open the bonnet of these devices before purchase then a lot of well known brands would fall totally beside the wayside in the quality stakes.'
    item[:url].to_s.should == "http://www.carltonaudiovisual.com.au/?q=node/view/1071"
    item[:price].should == 500.0
  end
end
