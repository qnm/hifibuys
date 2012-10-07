require 'spec_helper'

describe "Carlton" do

  it "should return an item for some example html" do
    VCR.use_cassette('carlton') do
      parser = Carlton.parse open(Carlton._source)
      item = parser.items[1].to_hash
      item[:name].should == "Marantz PM15 S2 Amplifier  and SA15S2 Cd player Limited Edition ... demo clearance $2200 each"
      item[:description].should == "Mr Ishiwata is hard at work still at Marantz after 30 years. It is said he only sleeps on aeroplanes beetween Hi Fi shows and the design studio. \r\n\r\nThe S2 15 series are Ken's latest limited edition stereo venture and have been getting rave initial press reports from the likes of Hi Fi News et al."
      item[:url].to_s.should == "http://www.carltonaudiovisual.com.au/?q=node/view/1605"
      item[:price].should == "$2200"
    end
  end
end
