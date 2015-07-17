module FeatureConfig
  class Setup
    module Loader
      class Yaml < Base
        private
          def fetch_config
            Dir[config_entries_path].inject({}) do |conf, entry|
              conf.update(YAML.load_file(entry))
            end
          end

          def config_entries_path
            Rails.root.join(*path, '*.yml')
          end
      end
    end
  end
end
