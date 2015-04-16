require 'spec_helper'

RSpec.describe Feature do
  let(:enabled_feature) { 'first_feature' }

  context 'class API' do
    subject                     { Feature }
    let(:features_names)        { Setup.configs.keys }
    let(:non_existing_feature)  { 'non_existing_feature' }

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
      subject { Feature.find(enabled_feature) }

      context '#enabled?' do
        it { expect(subject.enabled?).to be_truthy }
      end

      context '#available' do
        before { allow(subject).to receive(:filters).and_return([ double('Feature::Filter', ids: [1,2,3,4,5]), double('Feature::Filter', ids: [4,5,6]) ]) }
        it { expect(subject.available).to be_kind_of(Array) }
        it { expect(subject.available).to match_array([4,5]) }
      end

      context '#build_properties' do
        subject { Feature.store('new_awesome_feature', true)}
        context 'without filters' do
          before { subject.build_properties('test' => true, 'awesomeness' => 'high') }
          it { expect(subject.properties).to be_kind_of(Feature::Properties) }
          it { expect(subject.filters).to eq([]) }
        end

        context 'with filters' do
          before { subject.build_properties('test' => true, 'awesomeness' => 'high', 'available' => { 'deposit_range' => { 'min' => 100_000, 'max' => 200_000 } }) }
          it { expect(subject.filters).to be_kind_of(Array) }
          it { expect(subject.filters).to all(be_an(Feature::Filter)) }
        end
      end
    end

    context 'for disabled feature' do
      let(:disabled_feature) { 'disabled_feature' }
      subject { Feature.find(disabled_feature) }

      context '#enabled?' do
        it { expect(subject.enabled?).to be_falsey }
      end
    end
  end
end
