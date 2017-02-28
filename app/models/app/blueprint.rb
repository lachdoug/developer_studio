class App
  class Blueprint

    def initialize(app)
      @app = app
    end

    attr_reader :app

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

    # Define methods for blueprint sections. Methods look like...
    # def service_configurations
    #   @service_configurations ||= ServiceConfigurations.new(self)
    # end
    [ :version,
      :metadata,
      :display,
      :license,
      :base,
      :scripts,
      :database_seed,
      :components,
      :persistent_directories,
      :service_configurations,
      :replacement_strings,
      :persistent_files,
      :installed_packages,
      :system_packages,
      :workers,
      :rake_tasks,
      :template_files,
      :file_write_permissions,
      :custom_php_inis,
      :apache_htaccess_files,
      :apache_httpd_configurations,
      :required_modules,
      :ports,
      :actionators,
      :external_repositories,
      :environment_variables,
      :schedules
    ].each do |method_name|
      define_method method_name do
        instance_variable_set "@#{method_name}",
        ( instance_variable_get("@#{method_name}") ||
          "app/blueprint/#{method_name}".camelize.constantize.new(self) )
      end
    end

  end
end
