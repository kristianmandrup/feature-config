module FeatureConfig
  class Feature
    class Filter
      module Memory
        extend ActiveSupport::Concern
        extend ActiveSupport::Autoload

        autoload :Base
        autoload :QueryFilter
        autoload :DepositRange

        def initialize(feature, data)
          @data = data
          @feature = feature
        end

        def data
          @data
        end

        module ClassMethods
          def build_filters(feature, attributes)
            attributes.map { |name, options| class_for(name).new(feature, options) }
          end

          private
            def class_for(filter_name)
              "#{name}/#{Setup.storage_name}/#{filter_name}".classify.constantize
            end
        end
      end
    end
  end
end
