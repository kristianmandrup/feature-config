require 'spec_helper'

RSpec.describe Feature do
  let(:enabled_feature) { 'first_feature' }

  context 'class API' do
    subject                     { Feature }
    let(:features_names)        { FeatureConfig::Setup.instance.send(:features).keys }
    let(:non_existing_feature)  { 'non_existing_feature' }

    context '.find_by_name' do
      it { expect(subject.find_by_name(enabled_feature)).to be_kind_of(Feature) }
      it { expect(subject.find_by_name(non_existing_feature)).to be_nil }
    end

    context '.defined?' do
      it { expect(subject.defined?(enabled_feature)).to be_truthy }
      it { expect(subject.defined?(non_existing_feature)).to be_falsey }
    end

    context '.names' do
      it { expect(subject.names).to match_array(features_names) }
    end

    context '.store' do
      it do
        expect { subject.store(name: 'new_awesome_feature', enabled: true) }
          .to change { Feature.names.size }.by(1)
      end
    end
  end

  context 'instance API' do
    context 'for enabled feature' do
      subject { Feature.find_by_name(enabled_feature) }

      context '#enabled?' do
        it { expect(subject.enabled?).to be_truthy }
      end

      context '#available' do
        before do
          filters = [
            double('Feature::Filter', ids: [1, 2, 3, 4, 5]),
            double('Feature::Filter', ids: [4, 5, 6])
          ]
          allow(subject).to receive(:filters).and_return(filters)
        end
        it { expect(subject.available).to be_kind_of(Array) }
        it { expect(subject.available).to match_array([4, 5]) }
      end

      context '#load_properties' do
        subject { Feature.store(name: 'new_awesome_feature', enabled: true) }
        context 'without filters' do
          before do
            subject.load_properties('test' => true, 'awesomeness' => 'high')
          end
          it { expect(subject.properties).to be_kind_of(Feature::Properties) }
          it { expect(subject.filters).to eq([]) }
        end

        context 'with filters' do
          let(:deposit_ranges) { { 'min' => 100_000, 'max' => 200_000 } }
          after do
            subject.load_properties(
              'test'        => true,
              'awesomeness' => 'high',
              'available'   => { 'deposit_range' => deposit_ranges })
          end
          it do
            expect(Feature::Filter).to receive(:build_filters)
              .with(subject, 'deposit_range' => deposit_ranges)
          end
          it do
            expect(Feature::Properties).to receive(:new)
              .with('test' => true, 'awesomeness' => 'high')
          end
        end
      end
    end

    context 'for disabled feature' do
      let(:disabled_feature) { 'disabled_feature' }
      subject { Feature.find_by_name(disabled_feature) }

      context '#enabled?' do
        it { expect(subject.enabled?).to be_falsey }
      end
    end
  end
end
