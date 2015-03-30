class Feature
  @features = {}
  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def initialize(name, enabled, properties = {})
    @name       = name
    @enabled    = enabled
    @properties = properties
    bind_properties!
  end

  def disabled?
    !enabled?
  end

  def bind_properties!
    return unless properties
    properties.each do |property, value|
      define_singleton_method property.to_sym, proc { value }
    end
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
end
