module Apps
  module Blueprints
    class ServiceConfigurationsController < BaseController

      def update
        @service_configuration = @app.blueprint.service_configurations.find params[:id]
        @service_configuration.update strong_params
        render
      end

      def new
        @app.blueprint.service_configurations.build
        render
      end

      def create
        @app.blueprint.service_configurations.build strong_params
        render 'new'
      end

      def destroy
        @app.blueprint.service_configurations.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_service_configuration).
          permit( :publisher_namespace,
                  :type_path,
                  { variables_attributes:
                      [ :name, :value, :resolve_string, :resolve] } )
      end

    end
  end
end
