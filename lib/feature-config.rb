require 'feature-config/engine'
require 'feature-config/feature'

module FeatureConfig
  class << self
    def configs
      @configs ||= fetch_feature_configs('*.yml')
    end

    def properties
      @properies ||= fetch_feature_configs('configurations', '*.yml')
    end

    def initialize_feature_configs
      configs.each do |name, enabled|
        Feature.store(name, enabled, properties[name])
      end
    end

    private

    def fetch_feature_configs(*path)
      Dir[Rails.root.join('config', 'features', *path)].inject({}) do |conf, entry|
        conf.update(YAML.load_file(entry))
      end
    end
  end
end
