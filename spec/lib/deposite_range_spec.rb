require 'spec_helper'

RSpec.describe FeatureConfig::DepositeRange do
  context do
    subject { FeatureConfig::DepositeRange.new(query: 'deposite_range', min: 500_000, max: 600_000) }

    before do
      expect_any_instance_of(FeatureConfig::DepositeRange).to receive(:find_ids).and_return([1,2,3])
    end

    context '#ids' do
      it 'returns an array' do
        expect(subject.ids).to be_kind_of(Array)
      end

      it 'returns ids' do
        expect(subject.ids).to match_array([1,2,3])
      end
    end

    context '#name' do
      it 'returns name as string' do
        expect(subject.send(:name)).to be_kind_of(String)
      end

      it 'returns name of betrails user_query' do
        expect(subject.send(:name)).to eq('with_deposits')
      end
    end

    context '#value' do
      it 'returns value as range' do
        expect(subject.send(:value)).to be_kind_of(Range)
      end

      it 'returns range with correct values' do
        expect(subject.send(:value)).to eq(500_000..600_000)
      end
    end
  end
end
