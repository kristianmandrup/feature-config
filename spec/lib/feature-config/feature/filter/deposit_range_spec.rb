require 'spec_helper'

RSpec.describe Feature::Filter::DepositRange do
  context do
    subject { Feature::Filter::DepositRange.new(query: 'deposit_range', min: 500_000, max: 600_000) }
  end
end
