desc "It loads yaml file to storage"
namespace :feature_config do
  task :load_data => :environment do
    FeatureConfig.initialize!
  end
end
