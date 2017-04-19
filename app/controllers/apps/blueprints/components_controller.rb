module Apps
  module Blueprints
    class ComponentsController < BaseController

      def update
        @app.blueprint.components.update strong_params
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_components).permit( :path, :extract )
      end

    end
  end
end
