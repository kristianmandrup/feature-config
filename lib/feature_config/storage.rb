module FeatureConfig
  module Storage
    extend ActiveSupport::Autoload

    autoload :Memory
    autoload :RethinkDB
  end
end
