module FeatureConfig
  class Setup
    module Loader
      extend ActiveSupport::Autoload

      autoload :Base
      autoload :Yaml
    end
  end
end
