module FeatureConfig
  module Query
    attr_reader :ids

    def initialize(attributes)
      @attributes = attributes
      @ids = find_ids
    end

    private

    def find_ids
      Betrails::User.send(name, value).pluck(:id)
    end
  end
end
