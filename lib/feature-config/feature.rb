class Feature
  @features = {}
  attr_reader :name, :enabled, :properties

  alias_method :enabled?, :enabled

  def initialize(name, enabled, properties = nil)
    @name       = name
    @enabled    = enabled
    @properties = properties
    return unless properties
    @query = build_query(properties.delete('accessible_for'))
    bind_properties!
  end

  def disabled?
    !enabled?
  end

  def accessible_for
    return unless @query
    cache.write(query_cache_key, @query.call, expires_in: 60) if cache_expired?
    cache.read(query_cache_key)
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

  def bind_properties!
    properties.each { |property, value| build_property_method(property, value) }
  end

  def build_property_method(property, value)
    define_singleton_method property.to_sym, proc { value }
  end

  def build_query(attributes = nil)
    return unless attributes
    proc { "feature_config/#{ attributes['query'] }".classify.constantize.new(attributes).ids }
  end

  def query_cache_key
    "user_query_#{ @query.object_id }"
  end

  def cache
    Rails.cache
  end

  def cache_expired?
    !cache.exist?(query_cache_key)
  end
end
