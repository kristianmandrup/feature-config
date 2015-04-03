require 'singleton'

class ConfigsInitializer
  include Singleton
  include ConfigurationHandler

  def initialize
    @hash = fetch_feature_configs
  end
end
