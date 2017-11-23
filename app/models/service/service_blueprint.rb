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

    def service_definition
      # byebug
      compact_service_definition({
        publisher_namespace: base.publisher_namespace,
        type_path: base.type_path,
        accepts: base.accepts.form_data,
        title: metadata.software_display_title,
        description: metadata.software_display_description,
        major: metadata.blueprint_version_major,
        minor: metadata.blueprint_version_minor,
        release_level: metadata.blueprint_version_level,
        patch: metadata.blueprint_version_patch,
        service_container: base.name,
        service_handle_field: base.service_handle_field,
        dedicated: cast_as_boolean(base.dedicated),
        persistent: cast_as_boolean(base.persistent),
        immutable: cast_as_boolean(base.immutable),
        attach_post_build: cast_as_boolean(base.attach_post_build),
        attach_requires_restart: cast_as_boolean(base.attach_requires_restart),
        soft_service: cast_as_boolean(base.soft_service),
        shareable: cast_as_boolean(base.shareable),
        consumer_exportable: cast_as_boolean(base.consumer_exportable),
        target_environment_variables: target_environment_variables.form_data.map{ |v| { v[:variable_name].to_sym => v } }.inject(:merge),
        consumer_params: consumer_params.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge),
        # type_consumer_params: type_consumer_params.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge),
        configurators: configurators.form_data.map{ |v| { v[:name].to_sym => v.without(:set_script, :read_script) } }.inject(:merge),
        service_actionators: actionators.form_data.map{ |v| { v[:name].to_sym => v.without(:script) } }.inject(:merge),
        constants: constants.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge)
      })
    end

    def compact_service_definition(element)
      return element
      # byebug
      # if element.blank?
      #   nil
      # elsif element.is_a? Array
      #   element.map do |v|
      #     compact_service_definition v
      #   end.compact
      # elsif element.is_a? Hash
      #   element.map do |k,v|
      #     { k => compact_service_definition(v) }
      #   end.inject(:merge).delete_if do |k,v|
      #     v.blank?
      #   end
      # else
      #   element
      # end
    end

  end
end
