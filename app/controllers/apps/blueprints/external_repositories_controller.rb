module Apps
  module Blueprints
    class ExternalRepositoriesController < BaseController

      def update
        @app.blueprint.external_repositories.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.external_repositories.build_external_repository
        render 'apps/blueprints/external_repositories/update'
      end

      def destroy
        @app.blueprint.external_repositories.delete(params[:id].to_i)
        render 'apps/blueprints/external_repositories/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_external_repositories).
          permit( external_repositories_attributes: [ :url, :key ] )
      end

    end
  end
end
