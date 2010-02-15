require 'spec_helper'

describe "/entities/index.html.erb" do
  include EntitiesHelper

  before(:each) do
    assigns[:entities] = [
      stub_model(Entity,
        :name => "value for name"
      ),
      stub_model(Entity,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of entities" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
