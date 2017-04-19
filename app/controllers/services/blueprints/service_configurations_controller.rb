module Services
  module Blueprints
    class ServiceConfigurationsController < BaseController

      def update
        @service_configuration = @service.blueprint.service_configurations.find params[:id]
        @service_configuration.update strong_params
        render
      end

      def new
        @service.blueprint.service_configurations.build
        render
      end

      def create
        @service.blueprint.service_configurations.build strong_params
        render 'new'
      end

      def destroy
        @service.blueprint.service_configurations.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_service_configuration).
          permit( :publisher_namespace,
                  :type_path,
                  { variables_attributes:
                      [ :name, :value, :resolve_string, :resolve] } )
      end

    end
  end
end
