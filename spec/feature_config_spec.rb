require 'spec_helper'

RSpec.describe FeatureConfig do
  context 'on app initialization' do
    it 'takes configs and store them as a Hash' do
      expect(subject.configs).to be_kind_of(Hash)
    end

    it 'stores configs in memory and doesn\'t reload them' do
      expect(subject.configs.object_id).to eq(subject.configs.object_id)
    end

    it 'stores feature properties' do
      expect(subject.properties.key?('first_feature')).to be_truthy
    end
  end
end
