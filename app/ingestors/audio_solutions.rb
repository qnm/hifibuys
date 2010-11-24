require 'nibbler'
require 'uri'
include Feed

class AudioSolutionsItem < Nibbler
    SITE = "http://www.audiosolutions.net.au/sydney-audio-solutions/specials.html"

    element ".//td[1]/font" => :name, :with => lambda { |node| node.inner_html.strip.gsub(/[",]/,"") }
    element ".//td[2]/font" => :description, :with => lambda { |node| node.inner_html.strip.gsub(/[",]/,"") }
    element ".//td[3]/font" => :original_price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
    element ".//td[4]/font" => :price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
    element ".//td[1]/font" => :url, :with => lambda { |node| SITE  + "?source=hifibuys.com.au&product=#{node.inner_html.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') }

    # in this case there's no description in the datasource, so we return an empty string instead
    def to_hash
      { :shop_name    => "Audio Solutions",
        :shop_address => "",
        :shop_suburb  => "Leichardt",
        :shop_city    => "Sydney",
        :shop_state   => "NSW",
        :shop_country => "Australia",
        :description  => ''}.merge(super)
    end
end

class AudioSolutions < Nibbler
  consumes "http://audiosolutions.net.au/sydney-audio-solutions/specials.html"
  synchronises Item, :unique => :url

  elements '//div[@id="AREA__MAIN_CONTENT_COL1"]/div/div/div/table/tbody/tr[position() > 1]' => :items, :with => AudioSolutionsItem
end
