require 'spec_helper'
require 'lib/feature-config/setup/shared_examples_for_loader'

RSpec.describe FeatureConfig::Setup::Loader::Base do
  it_behaves_like 'loader'
end
