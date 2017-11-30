module Services
  module Blueprints
    class CapabilitiesController < BaseController

      def update
        @service.blueprint.capabilities.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_capabilities).
          permit( :allow, selected: [] )
      end

    end
  end
end
