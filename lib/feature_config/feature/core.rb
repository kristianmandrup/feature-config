module FeatureConfig
  class Feature
    module Core
      def enabled?
        enabled
      end

      def disabled?
        !enabled?
      end

      def load_properties(options)
        load_filters!(options)
        set_properties(options) if options
      end

      private
        def build_feature_config_properties(prop)
          @properties = Feature::Properties.new(prop)
        end
    end
  end
end
