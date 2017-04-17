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
          "Apache PHP": "apache_php",
          "Apache PHP 5/6": "apache_php56",
          "Base C": "base_c",
          "Jetty": "jetty",
          "Lua": "lua",
          "Meteor": "meteor",
          "NGINX": "nginx",
          "Node 4.7": "node4.7",
          "Node 6.9": "node6.9",
          "OpenJDK 8": "openjdk8",
          "OpenJDK 9": "openjdk9",
          "OpenJDK 7": "openjdk7",
          "Python": "python",
          "Rails 4": "rails4",
          "Rails 5": "rails5",
          "RStudio": "rstudio",
          "Sinatra": "sinatra",
          "Tomcat 7": "tomcat7",
          "Tomcat 8": "tomcat8",
          "Tomcat 9": "tomcat9",
          "X11": "x11"
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
          "Apache": "apache",
          "Lua": "lua",
          "npm": "npm",
          "PEAR": "pear",
          "PECL": "pecl",
          "PHP": "php"
        }
      }
    end

  end
end
