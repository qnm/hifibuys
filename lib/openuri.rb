require 'open-uri'

module Kernel
  private 
  alias openuri_original_open open
  def open(name, *rest, &block)
    if name.respond_to?(:open)
      name.open(*rest, &block)                                                                                           
    elsif name.respond_to?(:to_str) &&
          %r{\A[A-Za-z][A-Za-z0-9+\-\.]*://} =~ name &&
          (uri = URI.parse(name)).respond_to?(:open)
      OpenURI::open(name, *rest, &block)
    else
      open_uri_original_open(name, *rest, &block)
    end
  end
  module_function :open, :openuri_original_open
end


module OpenURI
  @cache = Rails.cache

  alias original_open open #:nodoc:
  def self.open(uri, *rest, &block)
    begin
      response = openuri_original_open(uri, *rest).read
      @cache.write(uri.to_s + "_stale", response)
      response
    rescue Exception => boom
      response = @cache.read(uri.to_s + "_stale")
      raise boom if response.nil?
      response
    end
  end
end
