require 'nibbler'
require 'uri'
include Feed

class TivoliItem < Nibbler
    element ".//td[2]/a[1]/@href" => :url, :with => lambda { |node| SITE + node.text }
    #element ".//td[5]" => :price, :with => lambda { |node| '$' + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s + ".00" }

    element ".//td[2]/h3/a[position() = 1]" => :name, :with => lambda { |node| node.text.gsub(/- Second [hH]and/,"").strip }
    element ".//td[2]/div" => :description, :with => lambda { |node| node.text.gsub(/Second [Hh]and/,"").strip }
    element ".//td[2]/h3/a/@href" => :url, :with => lambda { |node| node.text.split('&amp;').reject { |t| t.match('zenid') }.join('&amp;') }
    element ".//td[3]" => :price, :with => lambda { |node| '$' + node.text.scan(/\$([0-9,]{1,})/).first.first.to_s.gsub(',','') }


    def to_hash
      { 
        :seller_id    => 11,
        :submitter_id => 11,
      }.merge(super)
    end
end

class Tivoli < Nibbler
  consumes "http://tivolihifi.com/store/second-hand-equipment"
  synchronises Item, :unique => :url

  elements '//div[2]/div[2]/table/tr[position() > 1]' => :items, :with => TivoliItem
end
