class Scraper < ::Nibbler
  def initialize url
    doc = get_document url
    super doc
  end

  private

  # open web pages with UTF-8 encoding
  def get_document(url)
    URI === url ? Nokogiri::HTML::Document.parse(open(url), url.to_s, 'UTF-8') : url
  rescue OpenURI::HTTPError
    $stderr.puts "ERROR opening #{url}"
    Nokogiri('')
  end
end
