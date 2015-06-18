module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', before: :load_environment_config do
      FeatureConfig::Setup.initialize_features
      FeatureConfig::Setup.initialize_properties
    end

    initializer 'feature-config.feature_consistency_configs_helper',
                after: :initialize_logger do
      FeatureConfig::Setup.check_consistency_of_configs
    end
  end
end
