class Feature
  module Klass
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def find(name)
        features[name]
      end

      def store(name, enabled)
        features[name] = Feature.new(name, enabled)
      end

      def defined?(name)
        features.key?(name)
      end

      def names
        features.keys
      end

      private

      def features
        @features ||= {}
      end
    end
  end
end
