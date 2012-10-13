require 'spec_helper'

describe TagListWidget do
  has_widgets do |root|
    root << widget('tag_list')
  end

  let(:tag) { ActsAsTaggableOn::Tag.make }
  let(:tags) { [tag] }
  
  it "should render :display" do
    Item.should_receive(:tag_counts_on).at_least(1).times.and_return(tags)
    render_widget('tag_list', :display, :types).should have_selector("li")
    render_widget('tag_list', :display, :types).should have_content(tag.name)
  end
  
end
