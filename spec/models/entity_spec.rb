require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Entity, :type => :model do
  describe "has a factory that" do
    let(:entity) { Entity }

    it "returns an entity based upon name and category" do
      name = Faker::Company.name
      category = Faker::Name.name

      entity.should_receive(:name_like).with(name).and_return entity
      entity.should_receive(:category_like).with(category).and_return entity
      entity.from_text(name, category)
    end
  end

  describe "should split a string into entities" do
    it "without throwing an exception" do
      expect { Entity.extract(nil) }.to_not raise_exception
    end
  end


end
