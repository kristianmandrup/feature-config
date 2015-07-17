require 'spec_helper'

RSpec.describe FeatureConfig::Feature::Filter::Memory::DepositRange do
  context do
    subject do
      options = { query: 'deposit_range', min: 500_000, max: 600_000 }
      described_class.new(nil, options)
    end
    context '#entries' do
      let(:source) { spy('source') }
      it do
        allow(subject).to receive(:source).and_return(source)
        allow(source).to receive(:with_deposits)
        expect(source).to receive(:with_deposits)
        subject.entries
      end
    end

    context '#ids' do
      let(:entries) { double('entries') }
      it do
        expect(subject).to receive(:entries).and_return(entries)
        expect(entries).to receive(:pluck).and_return([1, 2, 3])
        expect(subject.ids).to eq([1, 2, 3])
      end
    end
  end
end
