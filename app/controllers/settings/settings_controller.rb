module Settings
  class SettingsController < ApplicationController

    def show
      @service_definition_publisher_namespaces = Settings::ServiceDefinitionNamespace.all
    end

  end
end
