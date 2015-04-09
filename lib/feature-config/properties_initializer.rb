require 'singleton'

module FeatureConfig
  class PropertiesInitializer
    include Singleton
    include ConfigurationHandler

    def initialize
      @hash = fetch_feature_configs('configurations')
    end
  end
end
