require 'spec_helper'

RSpec.describe Feature::Filter do
  context 'class API' do
    subject                  { Feature::Filter }
    let(:deposit_ranges)     { { 'min' => 1, 'max' => 1 } }
    let(:filters_attributes) { { 'deposit_range' => deposit_ranges } }

    context '.build_filters' do
      it do
        expect(subject.build_filters(subject, filters_attributes)).to be_kind_of(Array)
      end
      it do
        expect(subject.build_filters(subject, filters_attributes))
          .to all(be_an(Feature::Filter))
      end
    end
  end
end
