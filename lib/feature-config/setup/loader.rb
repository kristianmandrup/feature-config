module FeatureConfig
  class Setup::Loader
    attr_reader :hash, :path

    def initialize(path)
      @path = path
      @hash = fetch_config
    end

    def fetch_config
      raise NotImplementedError
    end
  end
end