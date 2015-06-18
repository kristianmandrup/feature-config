module FeatureConfig
  class Setup
    class << self
      def configs
        @configs ||= Loader::Yaml.new('config/features').hash
      end

      def properties
        @properties ||= Loader::Yaml.new('config/features/configurations').hash
      end

      def initialize_features
        configs.each { |name, enabled| Feature.store(name, enabled) }
      end

      def initialize_properties
        properties.each do |name, options|
          Feature.defined?(name) && Feature.find(name).build_properties(options)
        end
      end

      def check_consistency_of_configs
        properties.each_key do |name|
          log_warning(name) unless Feature.defined?(name)
        end
      end

      private

      def log_warning(feature_name)
        logger.warn "[FeatureConfig] #{feature_name}: " \
                    "couldn't find associated feature flag"
      end

      def logger
        Rails.logger
      end
    end
  end
end