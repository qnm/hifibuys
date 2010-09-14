require 'spec_helper'

describe "/entity_types/new.html.erb" do
  include EntityTypesHelper

  before(:each) do
    assigns[:entity_type] = stub_model(EntityType,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new entity_type form" do
    render

    response.should have_tag("form[action=?][method=post]", entity_types_path) do
      with_tag("input#entity_type_name[name=?]", "entity_type[name]")
    end
  end
end
