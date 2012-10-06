require 'nibbler'
require 'uri'
include Feed

class PymbleItem < Nibbler
  SITE = "http://www.pymblehifi.com.au/"

  element ".//td/span" => :name, :with => lambda { |node| tidy(node.inner_html.gsub('+', '')) }
  element ".//td[@class = 'style7']/div[@class = 'style7']" => :description, :with => lambda { |node| tidy(node.inner_html.scan(/\((.*)\)/)[0][0]) }
  element ".//td/span" => :url, :with => lambda { |node| SITE + "#{tidy(node.inner_html).downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') }
  #element ".//td[@class = 'style7']/div[@class = 'style7']" => :original_price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
  element ".//td[@class = 'style7']/div[@class = 'style7']/strong/font[@color = '#FF0000']" => :price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }

  element ".//td[@class = 'style7']/div[@class = 'style7']/strong/strong/font[@color = '#CC6600']" => :original_price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }

  def to_hash
    { 
      :seller_id    => 9,
      :submitter_id => 9,
    }.merge(super)
  end

end

class Pymble < Nibbler
  consumes APP_CONFIG['pipes']['pymble'][0]['sources'][0]
  synchronises Item, :unique => :url

  elements '//div[@class = "Specials"]/table/tr[position() > 6]' => :items, :with => PymbleItem
end
