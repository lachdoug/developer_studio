module Apps
  module Blueprints
    class ExternalRepositoriesController < BaseController

      def update
        @external_repository = @app.blueprint.external_repositories.find params[:id]
        @external_repository.update strong_params
        render
      end

      def new
        @app.blueprint.external_repositories.build
        render
      end

      def destroy
        @app.blueprint.external_repositories.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_external_repository).
          permit( :url, :key )
      end

    end
  end
end
