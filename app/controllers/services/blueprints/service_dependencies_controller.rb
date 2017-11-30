module Services
  module Blueprints
    class ServiceDependenciesController < BaseController

      def update
        @service_dependency = @service.blueprint.service_dependencies.find params[:id]
        @service_dependency.update strong_params
        render
      end

      def new
        @service.blueprint.service_dependencies.build
        render
      end

      def destroy
        @service.blueprint.service_dependencies.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_service_dependency).
          permit( :service_name )
      end

    end
  end
end
