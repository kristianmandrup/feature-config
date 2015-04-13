class Feature::Filter
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
