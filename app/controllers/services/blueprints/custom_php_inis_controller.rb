module Services
  module Blueprints
    class CustomPhpInisController < BaseController

      def update
        @custom_php_ini = @service.blueprint.custom_php_inis.find params[:id]
        @custom_php_ini.update strong_params
        render
      end

      def new
        @service.blueprint.custom_php_inis.build
        render
      end

      def destroy
        @service.blueprint.custom_php_inis.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_custom_php_ini).
          permit( :content )
      end

    end
  end
end
