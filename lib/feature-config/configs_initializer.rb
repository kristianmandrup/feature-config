require 'singleton'

module FeatureConfig
  class ConfigsInitializer
    include Singleton
    include ConfigurationHandler

    def initialize
      @hash = fetch_feature_configs
    end
  end
end
