require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Item", :type => :model do

  it "shouldn't allow a blank name to save" do
    a = Item.new
    a.save.should == false
  end

  it "should allow a populated name to save" do
    a = Item.new
    a.name = "Moo Cow Industries"
    a.save.should == true
  end
end
