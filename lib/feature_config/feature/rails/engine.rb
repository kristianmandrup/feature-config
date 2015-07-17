module FeatureConfig
  class Engine < Rails::Engine
    initializer 'feature-config.helpers', after: :app do |app|
      app.config.after_initialize do
        FeatureConfig.initialize!
      end
    end
  end
end
