require 'html/sanitizer'
require 'open-uri'

module Feed
  def consumes(source)
    include Feed
    class_eval %(
      class << self

        def _source
          "#{source}"
        end
      end
    )
  end

  def synchronises(sink, options)
    include Feed
    class_eval %(
      class << self

        attr_accessor :myoptions

        def _sink
      #{sink}
        end

      end
    )

    @myoptions = options
  end

  module ClassMethods
    def items
      parse(open(_source)).items
    end

    def synchronise()
      items.inject([]) do |items, ingestee|
        unique_method = @myoptions[:unique].to_s
        unique_value = ingestee.send(unique_method)
        item = _sink.send("find_or_create_by_#{unique_method}", unique_value)
        item.attributes = ingestee.to_hash.merge(:delta => true)
        items << item
      end
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end

  def sanitizer
    @@sanitizer ||= HTML::FullSanitizer.new
  end

  def tidy(value)
    # remove non-ascii chars
    value = ActiveSupport::Inflector.transliterate(value, '')

    # remove html
    value = sanitizer.sanitize(value)

    # remove rogue whitespace
    value = value.gsub(/\s+/, " ").strip
  end

  def self.all
    Dir.new('app/ingestors').collect { |basename|
      next if not basename =~ /^(.+)\.rb$/
      require basename
      (basename.split('.').first).camelize.constantize
    }.compact!
  end

end
