module Services
  module Blueprints
    class PortsController < BaseController

      def update
        @port = @service.blueprint.ports.find params[:id]
        @port.update strong_params
        render
      end

      def new
        @service.blueprint.ports.build
        render
      end

      def destroy
        @service.blueprint.ports.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_port).
          permit( :port, :external, :protocol )
      end

    end
  end
end
