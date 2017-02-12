class ApplicationConfig

  include ActiveModel::Model

  attr_accessor :config_yaml

  def self.config
    YAML.load(load.config_yaml).symbolize_keys
  end

  def self.load
      new.tap &:load_yaml
  end

  def load_yaml
    @config_yaml = config_yaml_file
  end

  def config_yaml_file
    File.read 'config/config.yml'
  end

  def update(config_params)
    assign_attributes config_params
    File.write 'config/config.yml', config_yaml
  end

end
