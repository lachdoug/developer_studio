module Apps
  module Blueprints
    class WorkersController < BaseController

      def update
        @app.blueprint.workers.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_workers).
          permit( :blocking, commands_attributes: [ :name, :command ] )
      end

    end
  end
end
