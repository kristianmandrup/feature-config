module FeatureConfig
  class DepositRange < QueryFilter
    def entries
      source.with_deposits(@attributes['min']..@attributes['max'])
    end
  end
end
