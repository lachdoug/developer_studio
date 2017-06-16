module Services
  module Blueprints
    class ConstantsController < BaseController

      def update
        @constant = @service.blueprint.constants.find params[:id]
        @constant.update strong_params
        render
      end

      def new
        @service.blueprint.constants.build
        render
      end

      def destroy
        @service.blueprint.constants.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_constant).permit( :name, :value )
      end

    end
  end
end
