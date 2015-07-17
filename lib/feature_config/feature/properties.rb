module FeatureConfig
  class Feature
    class Properties
      def initialize(data)
        @data = data
        bind_properties!
      end

      private

      def bind_properties!
        @data.each do |property, value|
          build_property_method(property, value)
        end
      end

      def build_property_method(property, value)
        define_singleton_method property, proc { value }
      end
    end
  end
end
