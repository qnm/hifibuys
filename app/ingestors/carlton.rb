require 'nibbler'
require 'uri'
include Feed

class CarltonItem < Nibbler
    SITE = "http://www.carltonaudiovisual.com.au/"
    element ".//tr/td/div/a" => :name, :with => lambda { |node| node.text.split("-").first.split(",").first.split("WAS").first.strip }
    element ".//tr/td/p[0]" => :description
    element ".//tr/td/p/img/@src" => :image_url, :with => lambda { |node| SITE + node.text }

    element ".//tr/td/div/a/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//tr/td/div" => :price, :with => lambda { |node| '$' + node.text.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_i.to_s }

    def to_hash
      {
        :seller_id    => 8,
        :submitter_id => 8,
      }.merge(super)
    end
end

class Carlton < Nibbler
  consumes APP_CONFIG['pipes']['carlton'][0]['sources'][0]
  synchronises Item, :unique => :url

  elements "//html/body/table/tr[2]/td[2]/table/tr[2]/td/table" => :items, :with => CarltonItem
end
