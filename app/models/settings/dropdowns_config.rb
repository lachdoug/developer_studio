module Settings
  class DropdownsConfig

    include ActiveModel::Model

    attr_accessor :config_yaml

    def self.config
      custom_dropdown_config.deep_merge default_dropdown_config
    end

    def self.custom_dropdown_config
      YAML.load(load.config_yaml).symbolize_keys
    end

    def self.load
        new.tap &:load_yaml
    end

    def load_yaml
      @config_yaml = config_yaml_file
    end

    def config_yaml_file
      File.read 'config/custom_dropdowns.yml'
    end

    def update(config_params)
      assign_attributes config_params
      File.write 'config/custom_dropdowns.yml', config_yaml
    end

    def self.default_dropdown_config
      {
        "frameworks": {
          "OpenJDK 8": "openjdk8",
          "OpenJDK 9": "openjdk9",
          "Apache PHP 5/6": "apache_php56",
          "OpenJDK 7": "openjdk7",
          "Jetty": "jetty",
          "Tomcat 8": "tomcat8",
          "Sinatra": "sinatra",
          "Meteor": "meteor",
          "Lua": "lua",
          "Tomcat 7": "tomcat7",
          "Node 4.7": "node4.7",
          "NGINX": "nginx",
          "Python": "python",
          "Apache PHP": "apache_php",
          "Rails 4": "rails4",
          "Rails 5": "rails5",
          "Node 6.9": "node6.9",
          "RStudio": "rstudio",
          "Tomcat 9": "tomcat9",
          "Base C": "base_c"
        },
        "script_languages": {
          "Javascript": "javascript",
          "Lua": "lua",
          "Shell": "sh",
          "PHP": "php",
          "Python": "python",
          "R": "r",
          "Text": "text"
        },
        "database_seed_languages": {
          "Javascript": "javascript",
          "Lua": "lua",
          "NoSQL": "nosql",
          "PHP": "php",
          "Python": "python",
          "R": "r",
          "Shell": "sh",
          "SQL": "sql",
          "Text": "text"
        },
        "required_module_types": {
          "npm": "npm",
          "Lua": "lua",
          "Apache": "apache",
          "PECL": "pecl",
          "PHP": "php",
          "PEAR": "pear"
        }
      }
    end

  end
end
