# Use this configuration to configure feature-config settings.
FeatureConfig.setup do |config|
  # ==> Tag Name
  # This setting will be used for displaying the tag in the logs generated.
  # Defaults to `FeatureConfig`.
  #
  # config.tag_name = 'FeatureConfig'

  # ==> Loader Class
  # This option is to set class which is responsible for loading files from
  # features and properties directory.
  # Default is `FeatureConfig::Setup::Loader::Yaml`.
  #
  # config.loader_class = FeatureConfig::Setup::Loader::Yaml

  # ==> Logger
  # This is used to set logger for logging purpose.
  # Defaults to `Rails.logger`.
  #
  # config.logger = Rails.logger

  # ==> Features Directory
  # It is the directory from where feature config select all +.yml+ files for
  # loading features.
  # Default features directory path is `config/features`.
  #
  # config.features_directory = 'config/features'

  # ==> Properties Directory
  # It is the directory from where properties of features will be selected from
  # +.yml+ files.
  # Default properties directory path is `config/features/configurations`.
  #
  # config.properties_directory = 'config/features/configurations'
end
