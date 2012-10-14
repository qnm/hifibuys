class Scraper < ::Nibbler
  def initialize url
    doc = get_document url
    super doc
  end

  private

  # open web pages with UTF-8 encoding
  def get_document(url)
    begin
      content = open(url)
    rescue OpenURI::HTTPError => e
      content = e.io
    end
    URI === url ? Nokogiri::HTML::Document.parse(content, url.to_s, 'UTF-8') : url
  end
end
