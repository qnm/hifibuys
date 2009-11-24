require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Items" do

  it "should sync carlton without error" do
    synchroniser = Synchroniser::Config::Params.new("/config/ingestors.yml", "carlton").get_sync
    synchroniser.sync
    SyncItem.find(:all)[0].item.should == "http://news.bbc.co.uk/sport1/hi/football/teams/n/newcastle_united/8329055.stm"
    SyncItem.find(:all)[0].group.should == "rss_test_feed"
  end

end
