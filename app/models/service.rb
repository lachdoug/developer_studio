class Service < Engine

  def blueprint
    @blueprint ||= ::Service::ServiceBlueprint.new(self)
  end

  # repo service def

  def service_definition
    blueprint.service_definition.to_yaml
  end

  # repo service def

  def repository_service_definition_namespace
    @repository_service_definition_namespace ||=
      Settings::ServiceDefinitionNamespace.
        new(blueprint.base.publisher_namespace)
  end

  def repository_service_definition
    @repository_service_definition ||=
      repository_service_definition_namespace.
        service_definition_for(blueprint.base.type_path)
  end

  def repository_service_definition_content
    # return nil unless repository_service_definition
    repository_service_definition.content
  end



end
