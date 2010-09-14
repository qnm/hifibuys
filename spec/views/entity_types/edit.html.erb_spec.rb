require 'spec_helper'

describe "/entity_types/edit.html.erb" do
  include EntityTypesHelper

  before(:each) do
    assigns[:entity_type] = @entity_type = stub_model(EntityType,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit entity_type form" do
    render

    response.should have_tag("form[action=#{entity_type_path(@entity_type)}][method=post]") do
      with_tag('input#entity_type_name[name=?]', "entity_type[name]")
    end
  end
end
