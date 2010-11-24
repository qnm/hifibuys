require 'nibbler'
require 'uri'
include Feed

class AudioConnectionItem < Nibbler
    SITE = "http://www.audioconnection.com.au"

    element ".//td[2]/a[1]" => :name, :with => lambda { |node| node.inner_html.strip.gsub(/[",]/,"") }
    element ".//td[2]/a[1]/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//td[5]" => :price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
    element ".//td[4]" => :original_price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }

    # in this case there's no description in the datasource, so we return an empty string instead
    def to_hash
      { :shop_name    => "Audio Connection",
        :shop_address => "",
        :shop_suburb  => "Leichardt",
        :shop_city    => "Sydney",
        :shop_state   => "NSW",
        :shop_country => "Australia",
        :description  => ''}.merge(super)
    end
end

class AudioConnection < Nibbler
  consumes "http://audioconnection.com.au/trade-ins-clearance-audio-equipment.asp"
  synchronises Item, :unique => :url

  elements '//table[@class="prodlist"]/tr[position() > 1]' => :items, :with => AudioConnectionItem
end
