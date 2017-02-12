module Apps
  module Blueprints
    class CustomPhpInisController < BaseController

      def update
        @app.blueprint.custom_php_inis.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.custom_php_inis.build_custom_php_ini
        render 'apps/blueprints/custom_php_inis/update'
      end

      def destroy
        @app.blueprint.custom_php_inis.delete(params[:id].to_i)
        render 'apps/blueprints/custom_php_inis/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_custom_php_inis).
          permit( custom_php_inis_attributes: [ :content ] )
      end

    end
  end
end
