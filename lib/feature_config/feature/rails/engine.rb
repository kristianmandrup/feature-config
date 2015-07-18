module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', after: :app do |app|
      app.config.after_initialize do
        FeatureConfig.load_environment_file and
        FeatureConfig.memory_storage? and
        FeatureConfig.initialize!
      end
    end
  end
end
