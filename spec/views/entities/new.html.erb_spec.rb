require 'spec_helper'

describe "/entities/new.html.erb" do
  include EntitiesHelper

  before(:each) do
    assigns[:entity] = stub_model(Entity,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new entity form" do
    render

    response.should have_tag("form[action=?][method=post]", entities_path) do
      with_tag("input#entity_name[name=?]", "entity[name]")
    end
  end
end
