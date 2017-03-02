module Apps
  module Blueprints
    class SystemPackagesController < BaseController

      def update
        @app.blueprint.system_packages.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.system_packages.build_system_package
        render 'apps/blueprints/system_packages/update'
      end

      def destroy
        @app.blueprint.system_packages.delete(params[:id].to_i)
        render 'apps/blueprints/system_packages/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_system_packages).
          permit( system_packages_attributes: [ :package, :version ] )
      end

    end
  end
end
