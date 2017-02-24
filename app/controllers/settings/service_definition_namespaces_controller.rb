module Settings
  class ServiceDefinitionNamespacesController < ApplicationController

    def show
      @service_definition_namespace = Settings::ServiceDefinitionNamespace.new( params[:id] )
    end

    def new
      @service_definition_namespace_builder = Settings::ServiceDefinitionNamespace::Builder.new()
    end

    def create
      @service_definition_namespace_builder = Settings::ServiceDefinitionNamespace::Builder.new(strong_params[:url])
      if @service_definition_namespace_builder.clone_remote
        redirect_to  settings_service_definition_namespace_path(id: @service_definition_namespace_builder.name), notice: "Service definitions for #{@service_definition_namespace_builder.name} have been cloned."
      else
        redirect_to settings_path, alert: "Failed to create service definitions for #{@service_definition_namespace_builder.name}. (#{@service_definition_namespace_builder.error_message})"
      end
    end

    def edit
      @service_definition_namespace = Settings::ServiceDefinitionNamespace.new( params[:id] )
      if @service_definition_namespace.pull
        redirect_to  settings_service_definition_namespace_path(id: @service_definition_namespace.name), notice: "Service definitions from #{@service_definition_namespace.name} have been pulled."
      else
        redirect_to  settings_service_definition_namespace_path(id: @service_definition_namespace.name), alert: "Failed to pull service definitions for #{@service_definition_namespace.name}. (#{@service_definition_namespace.error_message})"
      end
    end

    def destroy
      @service_definition_namespace = Settings::ServiceDefinitionNamespace.new( params[:id] )
      if @service_definition_namespace.delete
        redirect_to settings_path, notice: "Service definitions from #{@service_definition_namespace.name} have been deleted."
      else
        redirect_to  settings_service_definition_namespace_path(id: @service_definition_namespace.name), alert: "Failed to delete service definitions because #{e.message}."
      end
    end

    private

    def strong_params
      params.require(:settings_service_definition_namespace_builder).permit(:url)
    end

  end
end
