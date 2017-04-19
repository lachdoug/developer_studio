class App < Engine

  def blueprint
    @blueprint ||= App::Blueprint.new(self)
  end



end
