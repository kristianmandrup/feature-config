require 'singleton'

class Setup
  include Singleton

  def configs
    ConfigsInitializer.instance.hash
  end

  def properties
    PropertiesInitializer.instance.hash
  end

  def initialize_feature_configs
    configs.each do |name, enabled|
      Feature.store(name, enabled, properties[name])
    end
  end

  def check_consistency_of_configs
    properties.each_key { |name| log_warning(name) unless Feature.defined?(name) }
  end

  def logger
    Rails.logger
  end

  def log_warning(feature_name)
    logger.warn "[FeatureConfig] #{ feature_name }: couldn't find associated feature flag"
  end
end
