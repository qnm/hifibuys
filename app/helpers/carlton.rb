require 'nibbler'
require 'uri'
require 'nokogiri'

class CarltonItem < Nibbler
    SITE = "http://www.carltonaudiovisual.com.au/"
    element ".//tr/td/div/a" => :name, :with => lambda { |node| node.text.split("-").first.split(",").first.split("WAS").first.strip }
    element ".//tr/td/p" => :description
    element ".//tr/td/div/a/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//tr/td/div" => :price, :with => lambda { |node| node.text.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_f }

    def to_hash
      { :shop_name    => "Carlton Audio Visual",
        :shop_address => "164-172 Lygon Street",
        :shop_suburb  => "Carlton",
        :shop_city    => "Melbourne",
        :shop_state   => "VIC",
        :shop_country => "Australia"}.merge(super)
    end
end

class Carlton < Nibbler
  elements "//html/body/table/tr[2]/td[2]/table/tr[2]/td/table" => :items, :with => CarltonItem
end
