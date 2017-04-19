module Services
  module Blueprints
    class ComponentsController < BaseController

      def update
        @service.blueprint.components.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_components).permit( :path, :extract )
      end

    end
  end
end
