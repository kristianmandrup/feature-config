require 'spec_helper'
require 'lib/feature-config/setup/shared_examples_for_loader'
require 'lib/feature-config/setup/shared_examples_for_loader_subclasses'

RSpec.describe Setup::Loader::Yaml do
  it_behaves_like 'loader'
  it_behaves_like 'loader_subclass'
end
