module FeatureConfig
  class Setup
    module Loader
      class Base
        attr_reader :hash, :path
        def initialize(options = {})
          @path = options[:path]
          @hash = fetch_config
        end

        def fetch_config
          raise NotImplementedError
        end
      end
    end
  end
end
