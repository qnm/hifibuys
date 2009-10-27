class AudioConnectionIngestor
  include Synchroniser::Ingestor

  def ingest
    @data.search("tr/td/div/table/tr/td/table/tr").collect {|@current_item| itemise }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      { :name         => (@current_item/"/td[2]/a[1]").first.inner_html.strip.gsub(/[",]/,""),
        :description  => '',
        :url          => "http://www.audioconnection.com.au" + (@current_item/"/td[2]/a[1]").first.attributes['href'].strip,
        :price        => (@current_item/"/td[5]").first.inner_html.strip
      }.merge(@container.defaults)
    ) unless (@current_item/"/td[2]/a[1]").first.nil?
  end

end
