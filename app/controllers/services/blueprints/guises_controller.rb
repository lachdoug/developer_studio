module Services
  module Blueprints
    class GuisesController < BaseController

      def update
        @guise = @service.blueprint.guises.find params[:id]
        @guise.update strong_params
        render
      end

      def new
        @service.blueprint.guises.build
        render
      end

      def destroy
        @service.blueprint.guises.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_guise).
          permit( :service_name )
      end

    end
  end
end
