module FeatureConfig
  class Feature
    class Filter
      module Memory
        class DepositRange < QueryFilter
          def entries
            source.with_deposits(attributes['min']..attributes['max'])
          end
        end
      end
    end
  end
end