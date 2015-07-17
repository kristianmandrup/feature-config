require 'feature_config/feature/rails/engine'

module FeatureConfig
  extend ActiveSupport::Autoload

  autoload :Setup
  autoload :Storage
  autoload :Feature
  autoload :Filter
  autoload :Properties

  class << self
    delegate :configure, to: :'FeatureConfig::Setup'

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
