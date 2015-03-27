module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', before: :load_environment_config do
      FeatureConfig.initialize_feature_configs
    end
  end
end
