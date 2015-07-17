module FeatureConfig
  class Feature
    class Filter
      module Memory
        class Base < Filter
          class << self
            alias_method :store, :new
          end

          def ids
            entries.pluck(:id)
          end

          private
            def source
              Betrails::User
            end
        end
      end
    end
  end
end
