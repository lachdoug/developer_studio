class App
  class Blueprint

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def file
      @file ||= app.repository.blueprint
    end

    def save
      file.update content
    end

    def content
      @content ||= file.content
    end

    def update(new_content)
      @content = new_content
      save
    end

# single item sections

# Define methods for blueprint sections. Methods look like...
# def service_configurations
#   @service_configurations ||= ServiceConfigurations.new(self)
# end
[
  :metadata,
  :base,
  :scripts,
  :external_repositories,
  :ports,
  :system_packages,
  :installed_packages,
  :required_modules,
  :service_configurations,
  :environment_variables,
  :template_files,
  :replacement_strings,
  :database_seed,
  :file_write_permissions,
  :persistent_directories,
  :persistent_files,
  :components,
  :workers,
  :rake_tasks,
  :custom_php_inis,
  :apache_htaccess_files,
  :apache_httpd_configurations,
  :actionators,
  :schedules
].each do |method_name|
  define_method method_name do
    instance_variable_set "@#{method_name}",
    ( instance_variable_get("@#{method_name}") ||
      "app/blueprint/#{method_name}".camelize.constantize.new(self) )
  end
end

# def external_repositories
#   @external_repositories ||= ExternalRepositories.new(self)
# end
#
# def ports
#   @ports ||= Ports.new(self)
# end
#
# def system_packages
#   @system_packages ||= SystemPackages.new(self)
# end

# collection sections

    #
    # # Define methods for blueprint sections. Methods look like...
    # # def service_configurations
    # #   @service_configurations ||= ServiceConfigurations.new(self)
    # # end
    # [ :version,
    #   :metadata,
    #   :display,
    #   :license,
    #   :base,
    #   :scripts,
    #   :database_seed,
    #   :components,
    #   :persistent_directories,
    #   :service_configurations,
    #   :replacement_strings,
    #   :persistent_files,
    #   :installed_packages,
    #   :system_packages,
    #   :workers,
    #   :rake_tasks,
    #   :template_files,
    #   :file_write_permissions,
    #   :custom_php_inis,
    #   :apache_htaccess_files,
    #   :apache_httpd_configurations,
    #   :required_modules,
    #   :ports,
    #   :actionators,
    #   :external_repositories,
    #   :environment_variables,
    #   :schedules
    # ].each do |method_name|
    #   define_method method_name do
    #     instance_variable_set "@#{method_name}",
    #     ( instance_variable_get("@#{method_name}") ||
    #       "app/blueprint/#{method_name}".camelize.constantize.new(self) )
    #   end
    # end

  end
end
