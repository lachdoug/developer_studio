module Apps
  module Blueprints
    class RequiredModulesController < BaseController

      def update
        @app.blueprint.required_modules.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.required_modules.build_required_module
        render 'apps/blueprints/required_modules/update'
      end

      def destroy
        @app.blueprint.required_modules.delete(params[:id].to_i)
        render 'apps/blueprints/required_modules/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_required_modules).
          permit(required_modules_attributes: [ :type, :os_package, :name ] )
      end

    end
  end
end
