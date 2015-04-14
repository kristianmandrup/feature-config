class Feature
  @features = {}

  module Klass
    def find(name)
      @features[name]
    end

    def store(name, enabled, properties)
      @features[name] = Feature.new(name, enabled, properties)
    end

    def defined?(name)
      @features.key?(name)
    end

    def names
      @features.keys
    end

    def seed
      Setup.instance.configs.each do |name, enabled|
        store(name, enabled, Setup.instance.properties[name])
      end
    end
  end
end
