module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', before: :load_environment_config do
      Setup.initialize_features
      Setup.initialize_properties
    end

    initializer 'feature-config.feature_consistency_configs_helper',
                after: :initialize_logger do
      Setup.check_consistency_of_configs
    end
  end
end
