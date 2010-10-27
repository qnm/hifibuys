require 'nibbler'
require 'uri'

class AudioConnectionItem < Nibbler
    SITE = URI("http://www.audioconnection.com.au/")

    element ".//td[2]/a[1]" => :name, :with => lambda { |node| node.inner_html.strip.gsub(/[",]/,"") }
    element ".//td[2]/a[1]/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//td[5]" => :price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s + ".00" }

    def description
      ''
    end
end

class AudioConnection < Nibbler
  elements '//table[@class="prodlist"]/tr[position() > 1]' => :items, :with => AudioConnectionItem
end
