class Feature::Properties
  def initialize(properties)
    @properties = properties
    bind_properties!
  end

  private

  def bind_properties!
    @properties.each do |property, value|
      build_property_method(property, value)
    end
  end

  def build_property_method(property, value)
    define_singleton_method property.to_sym, proc { value }
  end
end
