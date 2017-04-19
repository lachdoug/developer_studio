module Apps
  module Blueprints
    class DatabaseSeedController < BaseController

      def update
        @app.blueprint.database_seed.update strong_params
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_database_seed).permit(
          :language, :content, :script )
      end

    end
  end
end
