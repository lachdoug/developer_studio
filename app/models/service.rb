class Service < Engine

  def blueprint
    @blueprint ||= ::Service::ServiceBlueprint.new(self)
  end

  def service_definition
    @service_definition ||= ::Service::ServiceDefinition.new(self)
  end

end
