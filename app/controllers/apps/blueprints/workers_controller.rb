module Apps
  module Blueprints
    class WorkersController < BaseController

      def update
        @app.blueprint.workers.update strong_params
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_workers).permit( :blocking )
      end

    end
  end
end
