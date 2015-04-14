class Feature
  extend Klass
  attr_reader :name, :enabled, :properties, :filters

  alias_method :enabled?, :enabled

  def initialize(name, enabled)
    @name     = name
    @enabled  = enabled
  end

  def disabled?
    !enabled?
  end

  def available
    return unless filters
    @available ||= filters.map(&:ids).reduce(&:&)
  end

  def build_properties(options)
    @filters = Feature::Filter.build_filters(options.delete('available')) if options.key?('available')
    @properties = Feature::PropertiesHash.new(options) if options
  end
end
