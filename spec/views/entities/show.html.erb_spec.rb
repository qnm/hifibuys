require 'spec_helper'

describe "/entities/show.html.erb" do
  include EntitiesHelper
  before(:each) do
    assigns[:entity] = @entity = stub_model(Entity,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
