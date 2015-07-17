require 'spec_helper'

RSpec.describe FeatureConfig::Feature::Filter do
  context 'class API' do
    subject                  { described_class }
    let(:deposit_ranges)     { { 'min' => 1, 'max' => 1 } }
    let(:filters_attributes) { { 'deposit_range' => deposit_ranges } }

    context '.build_filters' do
      it do
        expect(subject.build_filters(subject, filters_attributes)).to be_kind_of(Array)
      end
      it do
        expect(subject.build_filters(subject, filters_attributes))
          .to all(be_an(subject))
      end
    end
  end
end
