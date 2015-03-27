module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers' do
      FeatureConfig.initialize_feature_configs
    end
  end
end
