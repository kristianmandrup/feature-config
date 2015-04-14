require 'spec_helper'

RSpec.describe Feature do
  let(:features_names)        { Setup.configs.keys }
  let(:enabled_feature)       { 'first_feature' }
  let(:disabled_feature)      { 'disabled_feature' }
  let(:non_existing_feature)  { 'non_existing_feature' }

  context 'class API' do
    subject { Feature }

    context '.find' do
      it { expect(subject.find(enabled_feature)).to be_kind_of(Feature) }
      it { expect(subject.find(non_existing_feature)).to be_nil }
    end

    context '.defined?' do
      it { expect(subject.defined?(enabled_feature)).to be_truthy }
      it { expect(subject.defined?(non_existing_feature)).to be_falsey }
    end

    context '.names' do
      it { expect(subject.names).to match_array(features_names) }
    end

    context '.store' do
      it { expect { subject.store('new_awesome_feature', true) }.to change { Feature.names.size }.by(1) }
    end
  end

  context 'instance API' do
    context 'for enabled feature' do
      subject                 { Feature.find(enabled_feature) }
      let(:properties_keys)   { Setup.properties[enabled_feature].keys }

      context '#enabled?' do
        it { expect(subject.enabled?).to be_truthy }
      end

      context 'create singleton methods for first-level properties keys' do
        it { expect(properties_keys.all? { |meth| subject.properties.respond_to?(meth) }).to be_truthy }
      end

      context '#available' do
        before { allow(subject).to receive(:filters).and_return([ double('Feature::Filter', ids: [1,2,3,4,5]), double('Feature::Filter', ids: [4,5,6]) ]) }
        it { expect(subject.available).to be_kind_of(Array) }
        it { expect(subject.available).to match_array([4,5]) }
      end
    end

    context 'for disabled feature' do
      subject { Feature.find(disabled_feature) }

      context '#enabled?' do
        it { expect(subject.enabled?).to be_falsey }
      end
    end
  end
end
