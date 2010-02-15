require 'spec_helper'

describe "/entities/edit.html.erb" do
  include EntitiesHelper

  before(:each) do
    assigns[:entity] = @entity = stub_model(Entity,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit entity form" do
    render

    response.should have_tag("form[action=#{entity_path(@entity)}][method=post]") do
      with_tag('input#entity_name[name=?]', "entity[name]")
    end
  end
end
