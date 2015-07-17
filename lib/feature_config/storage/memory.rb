module FeatureConfig
  module Storage
    module Memory
      extend ActiveSupport::Concern

      included do
        attr_reader :name, :enabled, :filters
        alias_method :set_properties, :build_feature_config_properties
      end

      module ClassMethods
        delegate :first, :last, to: :all

        def find_by_name(name)
          features[name]
        end

        def store(options = {})
          features[options[:name]] = self.new(options)
        end

        def defined?(name)
          features.key?(name)
        end

        def names
          features.keys
        end

        def all
          features.values
        end

        private

        def features
          @features ||= {}
        end
      end

      def initialize(options = {})
        @name     = options[:name]
        @enabled  = options[:enabled]
        @filters  = []
      end

      def available
        @available ||= filters.map(&:ids).reduce(&:&)
      end

      def properties
        block_given? ? yield(@properties) : @properties
      end

      private
        def load_filters!(options)
          if _filters = options.delete('available')
            @filters = Feature::Filter.build_filters(self, _filters)
          end
        end
    end
  end
end
