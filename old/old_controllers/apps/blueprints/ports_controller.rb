module Apps
  module Blueprints
    class PortsController < BaseController

      def update
        @app.blueprint.ports.update strong_params
        render 'apps/blueprints/jsons/refresh'
      end

      def new
        @app.blueprint.ports.build_port
        render 'apps/blueprints/ports/update'
      end

      def destroy
        @app.blueprint.ports.delete(params[:id].to_i)
        render 'apps/blueprints/ports/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_ports).
          permit(ports_attributes: [ :port, :external, :protocol ] )
      end

    end
  end
end
