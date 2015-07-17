module FeatureConfig
  class Feature
    extend ActiveSupport::Autoload

    autoload :Core
    autoload :Filter
    autoload :Properties

    include Core
    include Setup.storage
  end
end
