module FeatureConfig
  module ConfigurationHandler
    attr_reader :hash

    private

    def fetch_feature_configs(*path)
      Dir[Rails.root.join('config', 'features', *path, '*.yml')].inject({}) do |conf, entry|
        conf.update(YAML.load_file(entry))
      end
    end
  end
end
