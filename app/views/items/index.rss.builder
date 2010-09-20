# app/views/posts/index.rss.builder
xml.channel do
  # Required to pass W3C validation.
  xml.atom :link, nil, {
    :href => items_url(:format => 'rss'),
    :rel => 'self', :type => 'application/rss+xml'
  }
  
  # Feed basics.
  xml.title             "Hifibuys"
  xml.description       "Cheap but awesome hifi"
  xml.link              items_url(:format => 'rss')
  
  # Posts.
  @items.each do |item|
    xml.item do
      xml.title         item.name
      xml.link          item.url
      xml.pubDate       item.created_at.to_s(:rfc822)
      xml.guid          item.url
    end
  end
end
