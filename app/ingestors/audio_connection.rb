require 'nibbler'
require 'uri'
include Feed

class AudioConnectionItem < Nibbler
    SITE = "http://www.audioconnection.com.au"

    element ".//td[2]/a[1]" => :name, :with => lambda { |node| Sanitize.clean(node.inner_html.strip.gsub(/[",]/,"")) }
    element ".//td[2]/a[1]/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//td[5]" => :price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
    element ".//td[4]" => :original_price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }

    # in this case there's no description in the datasource, so we return an empty string instead
    def to_hash
      { 
        :seller_id      => 6,
        :submitter_id   => 6,
        :description  => ''
      }.merge(super)
    end
end

class AudioConnection < Nibbler
  consumes APP_CONFIG['pipes']['audio_connection'][0]['sources'][0]

  synchronises Item, :unique => :url

  elements '//table[@class="prodlist"]/tr[position() > 1]' => :items, :with => AudioConnectionItem
end
