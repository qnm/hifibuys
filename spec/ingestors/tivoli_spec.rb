require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Tivoli" do

  it "should return an item for some example html" do
    VCR.use_cassette('tivoli') do
      parser = Tivoli.parse open(Tivoli._source)
      item = parser.items.first.to_hash
      item[:name].should == "ALR/Jordan Classic 5 Floorstanding Speakers in Alder"
      item[:description].should == 'The slender and elegant Classic 5 cabinet is made out of a material mix of MDF and pressboard just like the other models. Numerous ingenious cabinet stiffeners prevent bothersome resonances and thereby ensure homogenous and natural acoustics.'
      item[:url].to_s.should == "http://tivolihifi.com/special/floorstanding-speakers/alrjordan-classic-5-floorstanding-speakers-alder"
      item[:price].should == "$2500.00"
      item[:original_price].should == "$5000.00"
      item[:image_url].should == "http://tivolihifi.com/sites/default/files/imagecache/product_list/bild-classic-5.gif"
    end
  end
end
