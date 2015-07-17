require 'spec_helper'

RSpec.describe Feature::Properties do
  subject { Feature::Properties }
  let(:enabled_feature) { 'first_feature' }
  let(:properties) { FeatureConfig::Setup.instance.send(:properties) }

  context '.initialize' do
    after { subject.new(properties[enabled_feature]) }
    it { expect_any_instance_of(subject).to receive(:bind_properties!) }
  end

  context 'create a methods for each data keys' do
    subject do
      Feature::Properties.new(properties[enabled_feature])
    end
    it do
      expect(subject.instance_variable_get(:@data)
        .keys.all? { |method| subject.respond_to?(method) }).to be_truthy
    end
  end
end
