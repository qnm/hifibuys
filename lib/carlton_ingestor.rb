class CarltonIngestor
  include Synchroniser::Ingestor

  def ingest
    @data.search("/html/body/table/tr[2]/td[2]/table/tr[2]/td/table").collect {|@current_item| itemise }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      { :name         => (@current_item/"tr/td/div/a")[0].inner_html.split("-").first.split(",").first.split("WAS").first,
        :description  => (@current_item/"tr/td/p").map {|element| element.inner_html}.join(" ").gsub("\n"," ").gsub("\""," "),
        :url          => "http://www.carltonaudiovisual.com.au/" + (@current_item/"tr/td/div/a").first.attributes['href'],
        # we gotta grab out the minimum price from the array
        :price        => "$" + (@current_item/"tr/td/div").to_s.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s

      }.merge(@container.defaults)
    ) unless (@current_item/"tr/td/div/a").inner_html.scan(/\$([0-9\.,.]{1,})/).nil?
  end
end
