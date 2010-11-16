require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SimplyHifi" do

  it "should return an item for some example html" do
    parser = SimplyHifi.parse(open('spec/integration/siteref/simplyhifi.html'))	
    item = parser.items.first.to_hash
    item[:name].should == "Primare i21"
    item[:description].should == 'Primare i21 Stereo Integrated Amplifier. The amplifier is capable of delivering 75 watts into an 8 ohms load, 2 x 125W into 4 ohms, and incorporates full speaker protection against faulty input signals. Two individual DC-servos together with DC-blocking and protection circuit provide this state-of-the-art protection. The amplifier incorporates a massive 800VA toroidal transformer with separate windings for left and right power amp channels, effectively providing each channel with its own mono amplifier. Four line-level inputs. Black finish. Excellent condition. For further information go to http://www.primare.net/product.asp?ProductID=37 (Advertised for sale on consignment) Current list price $1,950'
    item[:url].to_s.should == "http://www.simplyhifi.com.au/?source=hifibuys.com.au&product=primare-i21"
    item[:price].should == "$999"
    item[:original_price].should == "$1950"
  end
end
