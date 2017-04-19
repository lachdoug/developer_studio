module Services
  module Blueprints
    class BasesController < BaseController

      def update
        @service.blueprint.base.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_base).
          permit( :name,
                  :deployment_type,
                  :http_protocol,
                  :memory_required,
                  :memory_recommended )
      end

    end
  end
end
