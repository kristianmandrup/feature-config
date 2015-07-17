module FeatureConfig
  class Feature
    class Filter
      module RethinkDB
        extend ActiveSupport::Concern

        included do
          include NoBrainer::Document
          # Fields
          field :data, type: Hash
          field :type, type: String

          # Associations
          belongs_to :feature, class_name: 'FeatureConfig::Feature'

          # Instance Methods
          # TODO: Implement
          # def entries
          #   raise NotImplementedError
          # end

          # def ids
          #   raise NotImplementedError
          # end
        end

        module ClassMethods
          def build_filters(feature, attributes)
            attributes['available'].each do |filter_name, options|
              where(type: filter_name, data: options).first ||
              create(data: options, type: filter_name, feature: feature)
            end
          end
        end
      end
    end
  end
end
