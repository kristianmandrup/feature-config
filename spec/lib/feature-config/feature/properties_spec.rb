require 'spec_helper'

RSpec.describe Feature::Properties do
  subject { Feature::Properties }
  let(:enabled_feature) { 'first_feature' }

  context '.initialize' do
    after { subject.new(Setup.properties[enabled_feature]) }
    it { expect_any_instance_of(subject).to receive(:bind_properties!) }
  end

  context 'create a methods for each properties keys' do
    subject { Feature::Properties.new(Setup.properties[enabled_feature]) }
    it do
      expect(subject.instance_variable_get(:@properties)
        .keys.all? { |meth| subject.respond_to?(meth) }).to be_truthy
    end
  end
end
