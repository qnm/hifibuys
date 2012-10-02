require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Item", :type => :model do

  it "shouldn't allow a blank name to save" do
    Item.make(:name => nil).valid?.should == false
  end

  it "should allow a populated name to save" do
    Item.make(:name => "Moo Cow").valid?.should == true
  end

  it "shouldn't allow a blank url to save" do
    Item.make(:url => nil).valid?.should == false
  end

end

describe Item do

  let(:product) { Item.make }

  before do
  end

  describe "should split the name into component parts" do
    it "should split nil without breaking" do
      product.name = nil
      expect { product.entities}.to_not raise_exception
    end
    
  end
end
