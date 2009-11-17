module Synchroniser::Ingestor::Uri
  include Synchroniser::Ingestor

  require 'open-uri'

  def load(uri)
    @data = open(uri).read
  end

end
