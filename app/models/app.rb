class App < Engine

  def blueprint
    @blueprint ||= ::App::AppBlueprint.new(self)
  end

end
