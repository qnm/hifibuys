require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AudioSolutions" do

  it "should return an item for some example html" do
    VCR.use_cassette('audio_solutions') do
      parser = AudioSolutions.parse open(AudioSolutions._source)
      item = parser.items.first.to_hash
      item[:name].should == "ARCAM AV9"
      item[:description].should == 'Surround Sound Pre Amplifier'
      item[:url].to_s.should == "http://www.audiosolutions.net.au/sydney-audio-solutions/specials.html?source=hifibuys.com.au&product=arcam-av9"
      item[:price].should == "$"
      item[:original_price].should == "$9999"
    end
  end
end
