class Setup
  class << self
    def configs
      @configs ||= Loader::Yaml.new('config/features').hash
    end

    def properties
      @properties ||= Loader::Yaml.new('config/features/configurations').hash
    end

    def build_properties(name, options)
      log_warning(name) unless Feature.defined?(name) && Feature.find(name).build_properties(options)
    end

    private

    def log_warning(feature_name)
      logger.warn "[FeatureConfig] #{ feature_name }: couldn't find associated feature flag"
    end

    def logger
      Rails.logger
    end
  end
end
