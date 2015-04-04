module FeatureConfig
  module Query
    attr_reader :ids

    def initialize(attributes)
      @attributes = attributes
      @ids = Betrails::User.send(name, value).pluck(:id)
    end
  end
end
