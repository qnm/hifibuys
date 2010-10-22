require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Tivoli" do

  it "should return an item for some example html" do
    parser = Tivoli.parse open('spec/integration/siteref/tivoli.html')									
    item = parser.items.first
    item.name.should == "Arcam Alpha 7 CD Player"
    item.description.should == 'The Alpha 7 CD player topped the UK sales charts for three years and has a long list of awards from the UK and internationally,...'
    item.url.to_s.should == "http://tivolihifi.com/store/index.php?main_page=product_info&cPath=13&products_id=566&zenid=0dc5c3cff2edb01cb475133bfbabe090"
    item.price.should == 499.0
  end
end
