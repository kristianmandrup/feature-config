class Feature::Filter
  def self.build_filters(attributes)
    attributes.map { |name, options| build(name, options) }
  end

  def self.build(filter_name, options)
    class_for(filter_name).new(options)
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def entries
    raise NotImplementedError
  end

  def ids
    raise NotImplementedError
  end

  private

  def self.class_for(filter_name)
    "#{ self.name }/#{ filter_name }".classify.constantize
  end

  def source
    raise NotImplementedError
  end
end