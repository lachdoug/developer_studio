module Apps
  module Blueprints
    class ComponentsController < BaseController

      def update
        @app.blueprint.components.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_components).
          permit( :path,
                  :extract,
                  sources_attributes: [
                    :label,
                    :url,
                    install_script_attributes: [:language, :content]
                  ] )
      end

    end
  end
end
