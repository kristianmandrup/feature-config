module FeatureConfig
  class Setup
    require 'singleton'
    include Singleton
    extend ActiveSupport::Autoload

    autoload :Loader

    class << self
      delegate :initialize!, :storage, :storage_name, to: :instance

      def configure
        yield(instance)
      end
    end

    attr_writer :tag_name, :logger, :loader_class, :features_directory
    attr_writer :properties_directory, :storage_name
    def initialize!
      initialize_features
      initialize_properties
    end

    def loader_class
      @loader_class ||= ::FeatureConfig::Setup::Loader::Yaml
    end

    def logger
      @logger ||= Rails.logger
    end

    def tag_name
      @tag_name ||= 'FeatureConfig'
    end

    def features_directory
      @features_directory ||= 'config/features'
    end

    def properties_directory
      @properties_directory ||= 'config/features/configurations'
    end

    def storage
      @storage ||= "::FeatureConfig::Storage::#{storage_name}".constantize
    end

    def storage_name
      @storage_name ||= :RethinkDB
    end

    private
      def features
        @features ||= load(features_directory)
      end

      def properties
        @properties ||= load(properties_directory)
      end

      def load(path)
        loader_class.new(path: path).hash
      end

      def initialize_features
        features.each { |name, enabled| FeatureConfig::Feature.store(name: name, enabled: enabled) }
      end

      def initialize_properties
        properties.each do |name, options|
          if feature = FeatureConfig::Feature.find_by_name(name)
            feature.load_properties(options)
          else
            log_warning(name)
          end
        end
      end

      def log_warning(feature_name)
        message = "#{feature_name}: couldn't find associated feature flag"

        if logger.respond_to?(:tagged)
          logger.tagged(tag_name) { logger.warn(message) }
        else
          logger.warn("[#{tag_name}] #{message}")
        end
      end
  end
end
