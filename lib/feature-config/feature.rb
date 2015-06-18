class Feature
  extend Klass
  attr_reader :name, :enabled, :filters

  alias_method :enabled?, :enabled

  def initialize(name, enabled)
    @name     = name
    @enabled  = enabled
    @filters  = []
  end

  def disabled?
    !enabled?
  end

  def available
    @available ||= filters.map(&:ids).reduce(&:&)
  end

  def build_properties(options)
    if options.key?('available')
      @filters = Feature::Filter.build_filters(options.delete('available'))
    end
    @properties = Feature::Properties.new(options) if options
  end

  def properties
    return @properties unless block_given?
    yield(@properties)
  end
end
