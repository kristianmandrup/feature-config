require 'set'
module FeatureConfig
  module Storage
    module Memory
      extend ActiveSupport::Concern
      TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE', 'on', 'ON'].to_set

      included do
        include ActiveModel::Serialization

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

        def enabled
          features.each_value.select(&:enabled?)
        end

        def disabled
          features.each_value.reject(&:enabled?)
        end

        def all_filters
          features.each_value.collect(&:filters).flatten
        end

        private
          def features
            @features ||= {}
          end
      end

      def find_filter(filter_name)
        filters.find { |filter| filter.type == filter_name }
      end

      def initialize(options = {})
        @name         = options[:name]
        self.enabled  = options[:enabled]
        @filters      = []
      end

      def persisted?
        true
      end

      def update(attributes = {})
        attributes.each do |attribute_name, value|
          send("#{ attribute_name }=", value)
        end
        self
      end

      def destroy
        self.class.send(:features).delete_if { |k, _| k == name }
      end

      def available
        @available ||= filters.map(&:ids).reduce(&:&)
      end

      def properties
        block_given? ? yield(@properties) : @properties
      end

      private
        attr_writer :name
        def enabled=(value)
          @enabled = TRUE_VALUES.include?(value)
        end

        def load_filters!(options)
          if _filters = options.delete('available')
            @filters = Feature::Filter.build_filters(self, _filters)
          end
        end
    end
  end
end
