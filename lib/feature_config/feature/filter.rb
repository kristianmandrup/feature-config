module FeatureConfig
  class Feature
    class Filter
      extend ActiveSupport::Autoload

      autoload :Core
      autoload Setup.storage_name

      include Core
      include Object.const_get("#{self}::#{Setup.storage_name}")
    end
  end
end
