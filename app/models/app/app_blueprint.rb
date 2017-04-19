class App
  class AppBlueprint < ::Engine::BlueprintBase

    # Define methods for blueprint sections. Methods look like...
    # def service_configurations
    #   @service_configurations ||= ServiceConfigurations.new(self)
    # end
    [ :metadata,
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
          "app/app_blueprint/#{method_name}".camelize.constantize.new(self) )
      end
    end

  end
end
