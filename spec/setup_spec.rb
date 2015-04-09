require 'spec_helper'

RSpec.describe FeatureConfig::Setup do
  context 'on app initialization' do
    subject { FeatureConfig::Setup.instance }

    it 'takes configs and store them as a Hash' do
      expect(subject.configs).to be_kind_of(Hash)
    end

    it 'stores configs in memory and doesn\'t reload them' do
      expect(subject.configs.object_id).to eq(subject.configs.object_id)
    end

    it 'stores feature properties' do
      expect(subject.properties.key?('first_feature')).to be_truthy
    end

    context 'raises warning on mismatched configuration' do
      let(:feature_name) { 'misnamed_feature' }
      let(:log) { spy('logger') }
      it do
        allow(log).to receive(:warn)
        allow(subject).to receive(:logger).and_return(log)
        subject.check_consistency_of_configs

        expect(log).to have_received(:warn).with("[FeatureConfig] #{ feature_name }: couldn't find associated feature flag")
      end
    end
  end
end
