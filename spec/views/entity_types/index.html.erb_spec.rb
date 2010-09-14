require 'spec_helper'

describe "/entity_types/index.html.erb" do
  include EntityTypesHelper

  before(:each) do
    assigns[:entity_types] = [
      stub_model(EntityType,
        :name => "value for name"
      ),
      stub_model(EntityType,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of entity_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
