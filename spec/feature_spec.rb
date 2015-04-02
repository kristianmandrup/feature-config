require 'spec_helper'

RSpec.describe Feature do
  context 'on app startup' do
    subject                     { Feature }
    let(:features_names)        { FeatureConfig.configs.keys }
    let(:enabled_feature)       { 'first_feature' }
    let(:disabled_feature)      { 'disabled_feature' }
    let(:non_existing_feature)  { 'non_existing_feature' }
    let(:properties_keys)       { FeatureConfig.properties[enabled_feature].keys }

    it 'creates an instance of Feature for each key in yml configuration' do
      expect(features_names.all? { |name| subject.find(name) }).to be_truthy
    end

    context 'correctly instantiate described features' do
      it { expect(subject.find(enabled_feature).enabled?).to be_truthy }
      it { expect(subject.find(disabled_feature).enabled?).to be_falsey }
    end

    context 'create singleton methods for first-level properties keys' do
      it { expect(properties_keys.all? { |meth| subject.find(enabled_feature).respond_to?(meth) }).to be_truthy }
    end

    context 'correctly responds whether a feature is created' do
      it { expect(subject.defined?(enabled_feature)).to be_truthy }
      it { expect(subject.defined?(non_existing_feature)).to be_falsey }
    end
  end
end
