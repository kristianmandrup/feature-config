class Setup::Loader
  attr_reader :hash, :path

  def initialize(path)
    @path = path
    @hash = fetch_config
  end
end
