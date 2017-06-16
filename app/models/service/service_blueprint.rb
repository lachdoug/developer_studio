class Service
  class ServiceBlueprint < ::Engine::BlueprintBase

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
      :constants,
      :target_environment_variables,
      :template_files,
      :replacement_strings,
      :persistent_directories,
      :consumer_params,
      :actionators,
      :configurators,
      :schedules
    ].each do |method_name|
      define_method method_name do
        instance_variable_set "@#{method_name}",
        ( instance_variable_get("@#{method_name}") ||
          "service/service_blueprint/#{method_name}".camelize.constantize.new(self) )
      end
    end

  end
end
