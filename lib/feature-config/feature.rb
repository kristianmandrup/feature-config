class Feature
  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def initialize(name, enabled, properties = {})
    @name       = name
    @enabled    = enabled
    @properties = properties
  end

  def self.find(name)
    cache.fetch(name)
  end

  def self.store(name, enabled, properties)
    cache.fetch(name, expires_in: 0) do
      Feature.new(name, enabled, properties)
    end
  end

  def disabled?
    !enabled?
  end

  def self.cache
    Rails.cache
  end
end
