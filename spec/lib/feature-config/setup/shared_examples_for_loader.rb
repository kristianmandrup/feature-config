require 'set'

RSpec.shared_examples_for 'loader' do
  context '.initialize' do
    after { described_class.new('configs/features') }
    it 'calls #fetch_config method' do
      expect_any_instance_of(described_class).to receive(:fetch_config)
    end
  end
end
