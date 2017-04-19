module Apps
  module Blueprints
    class CustomPhpInisController < BaseController

      def update
        @custom_php_ini = @app.blueprint.custom_php_inis.find params[:id]
        @custom_php_ini.update strong_params
        render
      end

      def new
        @app.blueprint.custom_php_inis.build
        render
      end

      def destroy
        @app.blueprint.custom_php_inis.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_custom_php_ini).
          permit( :content )
      end

    end
  end
end
