module Settings
  class DropdownsConfig

    include ActiveModel::Model

    attr_accessor :config_yaml

    def self.config
p "do merge"
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
        "resolve_strings": [
          "_Engines_Builder(ctype)",
          "_Engines_Builder(cont_user_id)",
          "_Engines_Builder(engine_name)",
          "_Engines_Builder(environments)",
          "_Engines_Builder(memory)",
          "_Engines_Builder(hostname)",
          "_Engines_Builder(domain_name)",
          "_Engines_Builder(repository)",
          "_Engines_Builder(http_protocol)",
          "_Engines_Builder(fqdn)",
          "_Engines_Builder(domain)",
          "_Engines_Builder(web_port)",
          "_Engines_Builder(build_name)",
          "_Engines_Builder(runtime)",
          "_Engines_Builder(set_environments)",
          "_Engines_Builder(engine_environment)",
          "_Engines_Builder(blueprint)",
          "_Engines_Builder(logs_container)",
          "_Engines_Builder(data_gid)",
          "_Engines_Builder(group_uid)",
          "_Engines_Builder(data_uid)",
          "_Engines_Builder(memory)",
          "_Engines_System(flavor)",
          "_Engines_System(pgsql_host)",
          "_Engines_System(mysql_host)",
          "_Engines_System(mongo_host)",
          "_Engines_System(internal_domain)",
          "_Engines_System(smtp_host)",
          "_Engines_System(timezone_country_city)",
          "_Engines_System(timezone)",
          "_Engines_System(hrs_from_gmt)",
          "_Engines_System(default_domain)",
          "_Engines_System(internal_domain)",
          "_Engines_System(publickey)",
          "_Engines_System(pubkey(type))",
          "_Engines_System(random(int))",
          "_Engines_System(service_resource(< service name >,< resource name >))",
          "_Engines_System(mgmt_host)",
          "_Engines_System(system_ip)",
          "_Engines_System(docker_ip)",
          "_Engines_System(system_hostname)",
          "_Engines_Environment(< env name >)",
          "_Engines_Field(< field name >)",
        ],
        "frameworks": {
          "Apache PHP": "apache_php",
          "Apache PHP 5/6": "apache_php56",
          "Base C": "base_c",
          "Docker": "docker",
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
          "Python 3.7": "python3.7",
          "Rails 4": "rails4",
          "Rails 5": "rails5",
          "RStudio": "rstudio",
          "Sinatra": "sinatra",
          "Tomcat 7": "tomcat7",
          "Tomcat 8": "tomcat8",
          "Tomcat 9": "tomcat9",
          "X11": "x11"
        },
        "template_file_languages": {
          "Javascript": "javascript",
          "JSON": "json",
          "Lua": "lua",
          "Shell": "sh",
          "PHP": "php",
          "Python": "python",
          "R": "r",
          "Text": "text",
          "YAML": "yaml"
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
        },
        "type_paths": [
          "auth",
          "avahi",
          "backup",
          "cert_auth",
          "cron",
          "database/nosql/mongo",
          "database/sql/mysql",
          "database/sql/pgsql",
          "dhcpd",
          "dns",
          "dyndns",
          "email",
          "filesystem/local/filesystem",
          "filesystem/remote/nfs",
          "filesystem/service/ftp",
          "filesystem/service/nfs",
          "firstrun",
          "imap",
          "ldap",
          "log_rotate",
          "logview",
          "mgmt",
          "nginx",
          "nosql_database",
          "redis",
          "schedule",
          "smtp",
          "syslog",
          "system",
          "wwwstats"
        ],
        "input_types": {
          "boolean [ Deprecated in favour of checkbox_boolean ]": "boolean",
          "checkbox (Single check box. Uses first item in collection for unchecked and second item for checked.)": "checkbox",
          "checkbox_boolean (Single check box. Returns 'true' when checked, otherwise 'false'. Input label shown beside checkbox.)": "checkbox_boolean",
          "check_boxes [ Deprecated in favour of checkboxes ]": "check_boxes",
          "checkboxes (Multiple checkboxes. Return an array of checked values. Value can be a comma-separated list. Uses collection for checkbox values and labels.)": "checkboxes",
          "country (Returns two-letter country code.)": "country",
          "date": "date",
          "datetime": "datetime",
          "decimal": "decimal",
          "email": "email",
          "file": "file",
          "float": "float",
          "hidden": "hidden",
          "integer": "integer",
          "language (Returns two-letter language code.)": "language",
          "password": "password",
          "password_with_confirmation": "password_with_confirmation",
          "radio_buttons (Uses collection for radio button values and labels.)": "radio_buttons",
          # "range": "range",
          "select (Uses collection for list values and labels.)": "select",
          "select_multiple (Return an array of selected values. Value can be a comma-separated list. Uses collection for list values and labels.)": "select_multiple",
          "select_with_input (Select with user input. Uses collection for list values and labels.)": "select_with_input",
          "string (Single line of text.)": "string",
          "time": "time",
          "time_zone": "time_zone",
          "tel": "tel",
          "text (Multiple lines of text.)": "text",
          "url": "url",
          "uuid": "uuid"
        }
      }
    end

  end
end
