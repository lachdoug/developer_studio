module Apps
  module Blueprints
    class DatabaseSeedsController < BaseController

      def update
        @app.blueprint.database_seed.update strong_params
        render 'apps/blueprints/jsons/refresh'
      end

      private

      def strong_params
        params.require(:app_blueprint_database_seed).
          permit( :language, :content, :script )
      end

    end
  end
end
