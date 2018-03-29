class Service
  class ServiceBlueprint < ::Engine::BlueprintBase

    # Define methods for blueprint sections. Methods look like...
    # def service_configurations
    #   @service_configurations ||= ServiceConfigurations.new(self)
    # end
    [ :metadata,
      :base,
      :disposition,
      :scripts,
      :external_repositories,
      :ports,
      :system_packages,
      :installed_packages,
      :required_modules,
      :included_files,
      :service_configurations,
      :environment_variables,
      :constants,
      :target_environment_variables,
      :template_files,
      :replacement_strings,
      :persistent_directories,
      :consumers,
      :consumer_scripts,
      :custom_files,
      :consumer_params,
      :actionators,
      :configurators,
      :schedules,
      :service_dependencies,
      :guises,
      :capabilities,
      :log_directories,
      :build_dependencies,
      :file_permissions,
      :soft_links,
      :backup_scripts,
      # :library_scripts
    ].each do |method_name|
      define_method method_name do
        instance_variable_set "@#{method_name}",
        ( instance_variable_get("@#{method_name}") ||
          "service/service_blueprint/#{method_name}".camelize.constantize.new(self) )
      end
    end

    def service_definition
      {
        publisher_namespace: base.publisher_namespace,
        type_path: base.type_path,
        title: metadata.software_display_title,
        description: metadata.software_display_description,
        major: metadata.blueprint_version_major,
        minor: metadata.blueprint_version_minor,
        release_level: metadata.blueprint_version_level,
        patch: metadata.blueprint_version_patch,
        service_container: base.name,
        service_handle_field: base.service_handle_field,
        dedicated: cast_as_boolean(disposition.dedicated),
        persistent: cast_as_boolean(disposition.persistent),
        immutable: cast_as_boolean(disposition.immutable),
        attach_post_build: cast_as_boolean(disposition.attach_post_build),
        attach_requires_restart: cast_as_boolean(disposition.attach_requires_restart),
        soft_service: cast_as_boolean(disposition.soft_service),
        shareable: cast_as_boolean(disposition.shareable),
        consumer_exportable: cast_as_boolean(disposition.consumer_exportable),
        consumerless: cast_as_boolean(disposition.consumerless),
        target_environment_variables: target_environment_variables.form_data.map{ |v| { v[:variable_name].to_sym => v } }.inject(:merge) || {},
        accepts: consumers.accepts.form_data,
        consumer_params: consumer_params.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge) || {},
        # type_consumer_params: type_consumer_params.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge) || {},
        configurators: configurators.form_data.map{ |v| { v[:name].to_sym => v.without(:set_script, :read_script) } }.inject(:merge) || {},
        service_actionators: actionators.form_data.map{ |v| { v[:name].to_sym => v.without(:script) } }.inject(:merge) || {},
        constants: constants.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge) || {},
        service_dependencies: service_dependencies.form_data,
        guises: guises.form_data,
        build_dependencies: build_dependencies.form_data
      }
    end

  end
end
