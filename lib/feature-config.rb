require 'feature-config/feature'
require 'feature-config/feature/properties'
require 'feature-config/feature/filter'
require 'feature-config/feature/filter/query_filter'
require 'feature-config/feature/filter/deposit_range'
require 'feature-config/setup'
require 'feature-config/setup/loader'
require 'feature-config/setup/loader/yaml'
require 'feature-config/feature/rails/engine'

module FeatureConfig
  class << self
    def setup(&block)
      Setup.configure(&block)
    end

    def initialize!
      load_environment_file
      Setup.initialize!
    end

    def target_file_name(rails_env = Rails.env)
      "config/features_config/#{ rails_env }.rb"
    end

    private
      def load_environment_file
        path = Rails.root.join(target_file_name)
        File.exists?(path) and require(path)
      end
  end
end
