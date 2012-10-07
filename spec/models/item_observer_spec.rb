require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ItemObserver do
  describe ".before_save" do
    before do
      @product = stub_model(Item)
      @product_observer = ItemObserver.instance
    end

    it "should attach entities as tags" do
      manufacturer_entities = [Faker::Company.name]
      type_entities = Faker::Name.name

      @product.should_receive(:manufacturer_list=).with(manufacturer_entities)
      @product.should_receive(:manufacturers).and_return(manufacturer_entities)

      @product.should_receive(:type_list=).with(type_entities)
      @product.should_receive(:types).and_return(type_entities)

      @product_observer.before_save(@product)
    end
  end
end
