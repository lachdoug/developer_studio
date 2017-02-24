module Settings
  class SettingsController < ApplicationController

    def show
      @service_definition_namespaces = Settings::ServiceDefinitionNamespace.all
    end

  end
end
