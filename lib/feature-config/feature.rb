class Feature
  @features = {}
  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def initialize(name, enabled, properties = nil)
    @name       = name
    @enabled    = enabled
    @properties = properties
    bind_properties! if properties
  end

  def disabled?
    !enabled?
  end

  def bind_properties!
    properties.each { |property, value| build_property_method(property, value) }
  end

  class << self
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
  end

  private

  def build_property_method(property, value)
    define_singleton_method property.to_sym do
      return value unless property == 'accessible_for'
      build_query(value).ids
    end
  end

  def build_query(attributes)
    "feature_config/#{ attributes['query'] }".classify.constantize.new(attributes)
  end
end
