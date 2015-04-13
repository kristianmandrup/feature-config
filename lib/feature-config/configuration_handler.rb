module FeatureConfig
  module ConfigurationHandler
    attr_reader :hash

    private

    def fetch_feature_configs(*path)
      Dir[config_entries_path(path)].inject({}) do |conf, entry|
        conf.update(YAML.load_file(entry))
      end
    end

    def config_entries_path(path)
      Rails.root.join('config', 'features', *path, '*.yml')
    end
  end
end
