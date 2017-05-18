class App < Engine

  def blueprint
    @blueprint ||= ::App::AppBlueprint.new(self)
  end

  def framework_has_rake_tasks
    ["rails4", "rails5", "sinatra"].include? blueprint.base.framework
  end

  def framework_has_custom_php_inis
    ["apache_php", "apache_php56"].include? blueprint.base.framework
  end

  def framework_has_apache_htaccess_files
    ["apache_php", "apache_php56"].include? blueprint.base.framework
  end

  def framework_has_apache_httpd_configurations
    ["apache_php", "apache_php56"].include? blueprint.base.framework
  end

end
