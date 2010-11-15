require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

Factory.define :item do |f|
  f.sequence(:id) { |n| "#{n}" }
  f.name { |n| "hi, my name is item number #{n}" }
end

describe "Item::Synchronise" do

  it "should do nothing given an empty source" do
    source = []
    items = Item.synchronise(source, {:key => :url} )
    items.should == []
  end

  it "should create a new Item when an existing Item does not exist" do
    test_key = :url
    test_value = "http:rob.sharp.id.au"

    Item.find(:all).should have(0).items

    @item = Factory(:item)
    source_item = double(@item)
    source_item.stub(test_key).and_return(test_value)
    source_item.stub(:to_hash).and_return({test_key => test_value})
    source_item.stub(:name).and_return("hi, my name is...")
    source = [source_item]

    items = Item.synchronise(source, {:key => test_key} )
    items.first.send(test_key).should ==  test_value

    Item.find(:all).should have(1).items
  end

  it "should update an Item when an existing Item exists" do
    test_key = :url
    test_value = "http:rob.sharp.id.au"

    @item = Factory(:item)
    Item.find(:all).should have(1).items
    source_item = double(@item)
    source_item.stub(test_key).and_return(test_value)
    source_item.stub(:to_hash).and_return({test_key => test_value})
    source_item.stub(:name).and_return("hi, my name is...")
    source = [source_item]

    items = Item.synchronise(source, {:key => test_key} )
    items.first.send(test_key).should ==  test_value

    Item.find(:all).should have(1).items
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

  it "should remove all tags when the original item is deleted and no further parents exist" do\
    Entity.create({:category => "type", :name => "DVD Player"})
    Entity.create({:category => "manufacturer", :name => "Denon"})

    a = Item.create({:name => "Denon 7500 DVD Player Special Offer"})
    a.type_list.should == ["DVD Player"]

    Item.tagged_with(["Denon", "DVD Player"], :any => true).should == [a]

    a.delete

    Item.tagged_with(["Denon", "DVD Player"], :any => true).should == []
  end
 
end
