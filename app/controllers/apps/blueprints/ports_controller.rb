module Apps
  module Blueprints
    class PortsController < BaseController

      def update
        @port = @app.blueprint.ports.find params[:id]
        @port.update strong_params
        render
      end

      def new
        @app.blueprint.ports.build
        render
      end

      def destroy
        @app.blueprint.ports.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_port).
          permit( :port, :external, :protocol )
      end

    end
  end
end
