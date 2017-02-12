module ServiceDefinitionGroups
  class ServiceDefinitionGroupsController < ApplicationController

    # before_action -> service_definition_name = params[:id] { set_service_definition service_definition_name }, only: [:show, :edit, :update, :destroy]

    def index
      @service_definition_groups = ServiceDefinitions::Group.all
    end

    def show
      @service_definition_group = ServiceDefinitions::Group.new( params[:id] )
    end

    def new
      @service_definition_group_builder = ServiceDefinitions::Group::Builder.new()
    end

    def create
      @service_definition_group_builder = ServiceDefinitions::Group::Builder.create(strong_params)
      redirect_to service_definition_groups_path, notice: "Service definitions from #{@service_definition_group_builder.name} have been cloned."
    rescue Rugged::InvalidError => e
      redirect_to service_definition_groups_path, alert: "Failed to create service definitions because #{e.message}."
    end

    def edit
      @service_definition_group = ServiceDefinitions::Group.new( params[:id] )
      if @service_definition_group.pull
        redirect_to service_definition_group_path(id: @service_definition_group.name), notice: "Service definitions from #{@service_definition_group.name} have been pulled."
      else
        redirect_to service_definition_groups_path, alert: "Failed to pull service definitions because #{e.message}."
      end
    end

    def destroy
      @service_definition_group = ServiceDefinitions::Group.new( params[:id] )
      if @service_definition_group.delete
        redirect_to service_definition_groups_path, notice: "Service definitions from #{@service_definition_group.name} have been deleted."
      else
        redirect_to service_definition_groups_path, alert: "Failed to delete service definitions because #{e.message}."
      end
    end

    private

    def strong_params
      params.require(:service_definitions_group_builder).permit(:url)
    end

  end
end
