class TivoliIngestor
  include Synchroniser::Ingestor

  def ingest
    @data.search("div[2]/div[2]/table/tr").collect {|@current_item| itemise }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      { :name         => (@current_item/"/td[2]/h3/a").first.inner_html.gsub(/- Second hand/,""),
        :description  => (@current_item/"/td[2]/div").first.inner_html,
        :url          => (@current_item/"/td[2]/h3/a").first.attributes['href'],
        :price        => "$" + (@current_item/"/td[3]").inner_html.scan(/\$([0-9\.,.]{1,})/).first.first
      }.merge(@container.defaults)
    ) unless (@current_item/"/td[2]").first.nil?
  end

end
