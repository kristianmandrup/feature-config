module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', before: :load_environment_config do
      FeatureConfig::Setup.instance.initialize_feature_configs
    end

    initializer 'feature-config.feature_consistency_configs_helper', after: :initialize_logger do
      FeatureConfig::Setup.instance.check_consistency_of_configs
    end
  end
end
