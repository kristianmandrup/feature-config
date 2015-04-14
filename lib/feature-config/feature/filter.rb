class Feature::Filter
  def self.build(filter_name, options)
    "#{ self.name }/#{ filter_name }".classify.constantize.new(options)
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

  def source
    raise NotImplementedError
  end
end
