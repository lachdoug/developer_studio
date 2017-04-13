module Apps
  module Blueprints
    class ServiceConfigurationsController < BaseController

      def update
        @service_configuration = @app.blueprint.service_configurations.find(params[:id])
        @service_configuration.update strong_params
        @service_configuration_id = params[:id]
        render 'apps/blueprints/service_configurations/update'
      end

      def new
        @service_configuration = @app.blueprint.service_configurations.build
        render 'apps/blueprints/service_configurations/new'
      end

      def create
        @service_configuration = @app.blueprint.service_configurations.build strong_params
        if @service_configuration.type_path.present?
          @service_configuration.load_variables_from_service_definition
          render 'apps/blueprints/service_configurations/create'
        else
          render 'apps/blueprints/service_configurations/new'
        end
      end

      def destroy
        @app.blueprint.service_configurations.delete(params[:id])
        render 'apps/blueprints/service_configurations/destroy'
      end

      private

      def strong_params
        params.require(:app_blueprint_service_configurations_service_configuration).
          permit( :publisher_namespace,
                :type_path,
                { variables_attributes: [:name, :value, :resolve_string, :resolve] } )
      end

    end
  end
end
