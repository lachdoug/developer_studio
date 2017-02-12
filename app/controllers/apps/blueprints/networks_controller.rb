module Apps
  module Blueprints
    class NetworksController < BaseController

      def update
        @app.blueprint.network.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_network).permit(:http_protocol, :framework_port_override, :web_root_directory)
      end

    end
  end
end
