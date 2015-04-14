class Feature
  extend Klass
  attr_reader :name, :enabled
  attr_accessor :properties, :filters

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
end
