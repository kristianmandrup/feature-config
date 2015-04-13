class Feature::Filter::DepositRange < Feature::Filter::QueryFilter
  def entries
    source.with_deposits(@attributes['min']..@attributes['max'])
  end
end
