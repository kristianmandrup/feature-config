require 'spec_helper'

RSpec.describe Feature::Filter do
  context 'class API' do
    subject                     { Feature::Filter }
    let(:filters_attributes)    { { 'deposit_range' => { 'min' => 500_000, 'max' => 550_000 } } }

    context '.build_filters' do
      it { expect(subject.build_filters(filters_attributes)).to be_kind_of(Array) }
      it { expect(subject.build_filters(filters_attributes)).to all(be_an(Feature::Filter)) }
    end
  end
end
