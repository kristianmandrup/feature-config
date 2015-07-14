require 'rails/generators/base'

module FeatureConfig
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Feature-Config initializer'

      def copy_initializer
        template 'feature_config.rb', FeatureConfig.target_file_name
      end
    end
  end
end
