module Apps
  module Blueprints
    class ServiceConfigurationsController < BaseController

      def update
        blueprint_section_view_requires_refresh = ( service_configurations_incomplete || service_configuration_creation )
        @app.blueprint.service_configurations.find(params[:id]).update(strong_params)
        if blueprint_section_view_requires_refresh
          render 'apps/blueprints/service_configurations/update'
        else
          render 'apps/blueprints/jsons/update'
        end
      end

      def new
        @app.blueprint.service_configurations.build
        render 'apps/blueprints/service_configurations/update'
      end

      def destroy
        @app.blueprint.service_configurations.delete(params[:id])
        render 'apps/blueprints/service_configurations/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_service_configurations_service_configuration).
          permit( :publisher_namespace,
                :type_path,
                { variables_attributes: [:name, :value, :resolve_string, :resolve] } )
      end

      def service_configurations_incomplete
        @app.blueprint.service_configurations.all.map{ |service_configuration| service_configuration.type_path.blank? }.any?
      end

      def service_configuration_creation
        @app.blueprint.service_configurations.all.count == params[:id].to_i
      end

    end
  end
end
