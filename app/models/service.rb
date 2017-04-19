class Service < Engine

  def blueprint
    @blueprint ||= Service::Blueprint.new(self)
  end

end
