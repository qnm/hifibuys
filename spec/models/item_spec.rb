require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Item do

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
