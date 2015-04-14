module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', before: :load_environment_config do
      Setup.configs.each { |name, enabled| Feature.store(name, enabled) }
    end

    initializer 'feature-config.feature_consistency_configs_helper', after: :initialize_logger do
      Setup.properties.each do |name, options|
        Setup.log_warning(name) unless Feature.defined?(name) && Feature.find(name).build_properties(options)
      end
    end
  end
end
