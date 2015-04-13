require 'set'

RSpec.shared_examples_for 'loader_subclass' do
  context '#hash' do
    let(:loader) { described_class.new('configs/features') }
    it 'returns hash' do
      expect(loader.hash).to be_kind_of(Hash)
    end
  end
end
