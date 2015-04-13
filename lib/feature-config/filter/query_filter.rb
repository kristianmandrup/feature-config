module FeatureConfig
  class QueryFilter < Filter
    def ids
      entries.pluck(:id)
    end

    private

    def source
      Betrails::User
    end
  end
end
