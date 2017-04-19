module Services
  module Blueprints
    class WorkersController < BaseController

      def update
        @service.blueprint.workers.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_workers).permit( :blocking )
      end

    end
  end
end
