module Synchroniser::Config

  class Params

    def initialize(file_name, ingestor_name)
      file_path = RAILS_ROOT
      config = YAML::load(File.open("#{file_path}#{file_name}"))

      environment = RAILS_ENV
      if config[RAILS_ENV].nil?
        environment = "test"
      end

      @config = config[environment][ingestor_name]
      if @config.nil?
        raise ArgumentError, "Unable to find the stanza '#{ingestor_name}' in the configuration file supplied"
      end
    end

    def get_sync
      container = build_container(@config['params']['container'])
      ingestors = build_ingestors(container)
      Synchroniser.new(container, ingestors)
    end

    def build_ingestors(container)
      require @config['ingestor'] + "_ingestor.rb"
      @ingestor = eval("#{@config['ingestor'].camelize}Ingestor.new")

      strategies = []
      @config['params']['url'].each { |url|
        @ingestor.load(url)
        strategies << @ingestor
      }
      strategies
    end

    def build_container(container)
      container_obj = eval "#{container['object']}.new({})"
      container['defaults'].each { |key, value|
        begin
          eval "container_obj.#{key}='#{value}'"
        rescue Exception
          raise "Please ensure item #{container['object']} has an attribute accessor for 'group'"
        end
      }
      container_obj
    end

  end

end