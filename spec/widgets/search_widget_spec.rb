require 'spec_helper'
#require 'capybara/rspec'

describe SearchWidget do
  #include Capybara::RSpecMatchers

  has_widgets do |root|
    root << widget('search')
  end
  
  it "should render :display" do
    render_widget('search', :display).should have_selector("form")
  end
  
end
