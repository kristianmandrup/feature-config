class Feature
  extend Klass
  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def initialize(name, enabled, properties = nil)
    @name       = name
    @enabled    = enabled
    @properties = properties
    return unless properties
    @filters = build_filters(properties.delete('available'))
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
    attributes.map { |name, options| Filter.build(name, options) } if attributes
  end
end
