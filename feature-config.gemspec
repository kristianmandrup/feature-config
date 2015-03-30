$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'feature-config/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'feature-config'
  s.version     = FeatureConfig::VERSION
  s.authors     = ['Ilya Shcherbinin']
  s.email       = ['ilya.shcherbinin@offsidegaming.com']
  s.homepage    = 'http://www.offsidegaming.com'
  s.summary     = 'Betrails feature-config gem'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 3.2.18'
end
