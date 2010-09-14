require 'spec_helper'

describe "/entity_types/show.html.erb" do
  include EntityTypesHelper
  before(:each) do
    assigns[:entity_type] = @entity_type = stub_model(EntityType,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
