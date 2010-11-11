require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SimplyHifi" do

  it "should return an item for some example html" do
    parser = SimplyHifi.parse open('spec/integration/siteref/simplyhifi.html')										
    item = parser.items.first.to_hash
    item[:name].should == "GamuT CD-1"
    item[:description].should == 'GamuT CD-1 CD Player. The DAC of the GamuT CD 1 is based on a Crystal CS 4390 DA converter IC with reduced jitter sensitivity.&nbsp; This IC delivers a wonderful fluid and non mechanical sounding midrange as well as treble with an exceptional smooth resolution of fine details.&nbsp; The Crystal CS 4390 oversamples at 128 times 44,100 Hz. That is 5,644,800 Hz.&nbsp; This is twice the speed of DSD/SACD.&nbsp; Most upsampling only goes to 192.000 Hz. The DAC is complemented by a very high quality CD transport mechanism. All circuit boards and the CD drive are mounted on rubber insulation, so that disturbing vibration is reduced. This unit is in excellent condition throughout, has just been reconditioned with a new laser assembly, and is complete with all original accessories and packaging. Original list price $6,999'
    item[:url].to_s.should == "http://www.simplyhifi.com.au/"
    item[:price].should == "$1699"
  end
end
