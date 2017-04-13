module Apps
  module Blueprints
    class SystemPackagesController < BaseController

      def update
        @system_package = @app.blueprint.system_packages.find params[:id]
        @system_package.update strong_params
        render
      end

      def new
        @app.blueprint.system_packages.build
        render
      end

      def destroy
        @app.blueprint.system_packages.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_system_package).
          permit( :package, :version )
      end

    end
  end
end
