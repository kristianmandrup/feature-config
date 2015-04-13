class Feature::Filter::QueryFilter < Feature::Filter
  def ids
    entries.pluck(:id)
  end

  private

  def source
    Betrails::User
  end
end
