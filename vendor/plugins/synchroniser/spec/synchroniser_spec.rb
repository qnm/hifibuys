require File.dirname(__FILE__) + '/spec_helper'

item = "abc123"
group = "def456"

describe Synchroniser do
  it "should always create a new post with new data" do
    container = DummyPost.new({:url => item})
    ingestors = [ DummyIngestor.new ]
    sync = Synchroniser.new(container, ingestors)
    sync_data = sync.ingest
    sync_data.first.before_validation.should == true 
  end

  it "should never create a new post with an existing object" do
    #TODO should use a fixture instead 
    a = SyncItem.new
    a.item = item
    a.save

    container = DummyPost.new({:url => item})
    ingestors = [ DummyIngestor.new ]
    sync = Synchroniser.new(container, ingestors)
    sync_data = sync.ingest
    sync_data.first.before_validation.should == false 
  end 

  it "should set the correct group from a config" do
    config = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss")
    synchroniser = config.get_sync
    synchroniser.container.group.should == "rss_test_feed"
  end

  it "should set the correct url from a config" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    synchroniser.ingest[0].url.should == "http://news.bbc.co.uk/sport1/hi/football/teams/n/newcastle_united/8329055.stm"
  end

  it "should correctly set the title upon ingestion" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    synchroniser.ingest[0].title.should == "Ashley takes Newcastle off market"
  end

  it "should set container defaults corrently" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    synchroniser.container.test_default.should == "random_default_name"
  end

  it "should sync without error" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    synchroniser.sync
  end



end
