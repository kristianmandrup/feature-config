class Feature
  @features = {}
  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def initialize(name, enabled, properties = nil)
    @name       = name
    @enabled    = enabled
    @properties = properties
    return unless properties
    build_filters(properties.delete('available'))
    bind_properties!
  end

  def disabled?
    !enabled?
  end

  def available
    @available ||= filters.inject(Set.new) { |acc, filter| acc.merge(filter.ids) }.to_a
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

  attr_reader :filters

  def bind_properties!
    properties.each { |property, value| build_property_method(property, value) }
  end

  def build_property_method(property, value)
    define_singleton_method property.to_sym, proc { value }
  end

  def build_filters(attributes)
    return unless attributes
    @filters = attributes.map do |name, options|
      "feature_config/#{ name }".classify.constantize.new(options)
    end
  end
end
