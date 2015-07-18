module FeatureConfig
  module Storage
    module RethinkDB
      extend ActiveSupport::Concern

      included do
        include NoBrainer::Document

        field :name, type: String
        field :enabled, type: ::NoBrainer::Boolean
        field :properties, type: Hash

        has_many :filters, dependent: :destroy, class_name: :'FeatureConfig::Feature::Filter'

        scope :enabled, -> { where(enabled: true) }
        scope :disabled, -> { where(enabled: false) }

        def properties
          build_feature_config_properties(super)
          block_given? ? yield(@properties) : @properties
        end
      end

      module ClassMethods
        def find_by_name(name)
          where(name: name).first
        end

        def store(options = {})
          find_by_name(options[:name]) || create(options)
        end

        def defined?(name)
          where(name: name).any?
        end

        def names
          all.without_ordering.pluck(:name).raw.collect{ |a| a['name'] }
        end

        def all_filters
          FeatureConfig::Feature::Filter.all.eager_load(:feature)
        end
      end

      def available
        @available ||= filters.map(&:ids).reduce(&:&)
      end

      def find_filter(filter_name)
        filters.where(type: filter_name).first
      end

      private
        def set_properties(properties)
          update(properties: properties)
        end

        def load_filters!(options)
          Feature::Filter.build_filters(self, options) if options.has_key?('available')
          options.delete('available')
        end
    end
  end
end
