require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Item::Synchronise" do

  it "should do nothing given an empty source" do
    source = []
    items = Item.synchronise(source, {:key => :url} )
    items.should == []
  end

  it "should create a new Item when an existing Item does not exist" do
    test_key = :url
    test_value = "http:rob.sharp.id.au"

    Item.find(:all).count.should == 0

    source_item = double("IngestedItem")
    source_item.stub(test_key).and_return(test_value)
    source_item.stub(:to_hash).and_return({test_key => test_value})
    source = [source_item]

    items = Item.synchronise(source, {:key => test_key} )
    items.first.send(test_key).should ==  test_value

    Item.find(:all).count.should == 1
  end

  it "should update an Item when an existing Item exists" do
    test_key = :url
    test_value = "http:rob.sharp.id.au"

    Item.create({test_key => test_value})

    Item.find(:all).count.should == 1

    source_item = double("IngestedItem")
    source_item.stub(test_key).and_return(test_value)
    source_item.stub(:to_hash).and_return({test_key => test_value})
    source = [source_item]

    items = Item.synchronise(source, {:key => test_key} )
    items.first.send(test_key).should ==  test_value

    Item.find(:all).count.should == 1
  end

  it "should delete an Item when the Item no longer exists in the source"

  it "should tag a manufacturer when the manufacturer is recognised" do
    Entity.create({:category => "manufacturer", :name => "Arcam"})

    a = Item.create({:name => "Arcam AVR 350"})
    a.manufacturer_list.should == ["Arcam"]
  end

  it "should tag a type when the type is recognised" do
    Entity.create({:category => "type", :name => "DVD Player"})

    a = Item.create({:name => "Denon 7500 DVD Player Special Offer"})
    a.type_list.should == ["DVD Player"]
end
 
end
