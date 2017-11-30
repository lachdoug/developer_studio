module Services
  module Blueprints
    class BuildDependenciesController < BaseController

      def update
        @build_dependency = @service.blueprint.build_dependencies.find params[:id]
        @build_dependency.update strong_params
        render
      end

      def new
        @service.blueprint.build_dependencies.build
        render
      end

      def destroy
        @service.blueprint.build_dependencies.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_build_dependency).
          permit( :path )
      end

    end
  end
end
