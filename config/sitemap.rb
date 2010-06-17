# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.hifibuys.com.au"

SitemapGenerator::Sitemap.add_links do |sitemap|

  # add all individual items
  Item.find(:all).each do |i|
    sitemap.add item_path(i), :lastmod => i.updated_at
  end

end
