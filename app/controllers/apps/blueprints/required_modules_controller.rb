module Apps
  module Blueprints
    class RequiredModulesController < BaseController

      def update
        @required_module = @app.blueprint.required_modules.find params[:id]
        @required_module.update strong_params
        render
      end

      def new
        @app.blueprint.required_modules.build
        render
      end

      def destroy
        @app.blueprint.required_modules.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_required_module).
          permit( :type, :os_package, :name )
      end

    end
  end
end
