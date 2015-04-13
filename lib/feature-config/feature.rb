class Feature
  @features = {}

  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def self.find(name)
    @features[name]
  end

  def self.store(name, enabled, properties)
    @features[name] = Feature.new(name, enabled, properties)
  end

  def self.defined?(name)
    @features.key?(name)
  end

  def self.names
    @features.keys
  end

  def self.seed
    Setup.instance.configs.each do |name, enabled|
      store(name, enabled, Setup.instance.properties[name])
    end
  end

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
    return unless filters
    @available ||= filters.map(&:ids).reduce(&:&)
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
      "feature/filter/#{ name }".classify.constantize.new(options)
    end
  end
end
