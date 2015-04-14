class Feature::PropertiesHash
  def initialize(properties)
    @properties = properties
    bind_properties!
  end

  private

  def bind_properties!
    @properties.each { |property, value| build_property_method(property, value) }
  end

  def build_property_method(property, value)
    define_singleton_method property.to_sym, proc { value }
  end
end
