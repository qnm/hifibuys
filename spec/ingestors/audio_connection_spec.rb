require 'spec_helper'

describe "AudioConnection" do

  class AudioConnection
  end

  pending "should return an item for some example html" do

    VCR.use_cassette('audio_connection') do
      parser = AudioConnection.parse open(AudioConnection._source)
      item = parser.items.first.to_hash
      item[:name].should == "Transparent Reference XL 1.2 metre pair"
      item[:description].should == ''
      item[:url].to_s.should == "http://www.audioconnection.com.au/products/transparent-reference-xl-1.2-metre-pair.asp"
      item[:price].should == "$1800"
      item[:original_price].should == "$"
    end
  end
end
