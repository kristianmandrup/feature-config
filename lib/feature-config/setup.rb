require 'singleton'

class Setup
  include Singleton

  def configs
    @configs ||= Loader::Yaml.new('config/features').hash
  end

  def properties
    @properties ||= Loader::Yaml.new('config/features/configurations').hash
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
