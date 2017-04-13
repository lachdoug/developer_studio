module Apps
  module Blueprints
    class MemoriesController < BaseController

      def update
        @app.blueprint.memory.update strong_params
        render 'apps/blueprints/jsons/refresh'
      end

      private

      def strong_params
        params.require(:app_blueprint_memory).permit(:required, :recommended)
      end

    end
  end
end
