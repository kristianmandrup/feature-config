module FeatureConfig
  class DepositRange < Query
    private

    def name
      'with_deposits'
    end

    def value
      @attributes['min']..@attributes['max']
    end
  end
end
