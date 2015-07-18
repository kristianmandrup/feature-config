module FeatureConfig
  class Feature
    class Filter
      module Core
        def entries
          raise NotImplementedError
        end

        def ids
          raise NotImplementedError
        end

        def data
          raise NotImplementedError
        end

        def update(data)
          raise NotImplementedError
        end

        def type
          raise NotImplementedError
        end

        private
          def source
            raise NotImplementedError
          end
      end
    end
  end
end
