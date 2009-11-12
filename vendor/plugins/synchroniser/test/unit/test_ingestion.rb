require 'test_helper.rb'
require RAILS_ROOT + '/vendor/plugins/synchroniser/lib/synchroniser.rb'


class TestIngestion < ActiveSupport::TestCase

  test "test grouping" do
    config = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss")
    synchroniser = config.get_sync
    assert_equal("rss_test_feed", synchroniser.container.group)
  end

  test "test a url" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    assert_equal("http://news.bbc.co.uk/sport1/hi/football/teams/n/newcastle_united/8329055.stm", synchroniser.ingest[0].url)
  end

  test "test a title" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    assert_equal("Ashley takes Newcastle off market", synchroniser.ingest[0].title)
  end

  test "test sync" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    synchroniser.sync
  end

  test "test defaults" do
    synchroniser = Synchroniser::Config::Params.new("/vendor/plugins/synchroniser/test/docs/ingestors.yml", "rss").get_sync
    assert_equal("random_default_name", synchroniser.container.test_default)
  end
end
