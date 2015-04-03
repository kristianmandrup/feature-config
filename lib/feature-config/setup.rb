require 'singleton'

class Setup
  include Singleton

  def configs
    @configs ||= fetch_feature_configs('*.yml')
  end

  def properties
    @properies ||= fetch_feature_configs('configurations', '*.yml')
  end

  def initialize_feature_configs
    configs.each do |name, enabled|
      Feature.store(name, enabled, properties[name])
    end
  end

  def check_consistency_of_configs
    properties.each_key { |name| log_warning(name) unless Feature.defined?(name) }
  end

  private

  def fetch_feature_configs(*path)
    Dir[Rails.root.join('config', 'features', *path)].inject({}) do |conf, entry|
      conf.update(YAML.load_file(entry))
    end
  end

  def logger
    Rails.logger
  end

  def log_warning(feature_name)
    logger.warn "[FeatureConfig] #{ feature_name }: couldn't find associated feature flag"
  end
end
