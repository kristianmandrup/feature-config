module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', before: :load_environment_config do
      Setup.configs.each { |name, enabled| Feature.store(name, enabled) }
    end

    initializer 'feature-config.feature_consistency_configs_helper', after: :initialize_logger do
      Setup.properties.each do |name, options|
        unless Feature.defined?(name)
          Setup.log_warning(name)
          next
        end
        Feature.find(name).filters = Feature::Filter.build_filters(options.delete('available')) if options.key?('available')
        Feature.find(name).properties = Feature::PropertiesHash.new(options) if options
      end
    end
  end
end
