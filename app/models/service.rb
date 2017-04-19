class Service < Engine

  def blueprint
    @blueprint ||= ::Service::ServiceBlueprint.new(self)
  end

end
