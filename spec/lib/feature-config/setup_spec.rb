require 'spec_helper'

RSpec.describe FeatureConfig::Setup do
  subject { FeatureConfig::Setup.instance }
  let(:properties) { subject.send(:properties) }
  let(:features) { subject.send(:features) }

  context '#features' do
    it { expect(features).to be_kind_of(Hash) }

    it 'stores configs in memory and doesn\'t reload them' do
      expect(features.object_id).to eq(subject.send(:features).object_id)
    end
  end

  context '#properties' do
    it { expect(properties).to be_kind_of(Hash) }

    it 'stores feature properties' do
      expect(properties.key?('first_feature')).to be_truthy
    end
  end

  context 'raises warning on mismatched configuration' do
    let(:feature_name) { 'misnamed_feature' }
    let(:log) { Rails.logger }

    before do
      allow(log).to receive(:warn)
      allow(subject).to receive(:logger).and_return(log)
    end

    it do
      expect(log).to receive(:warn)
        .with("#{feature_name}: " \
          "couldn't find associated feature flag")
      subject.initialize!
    end
  end
end
