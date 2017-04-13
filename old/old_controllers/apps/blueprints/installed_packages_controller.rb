module Apps
  module Blueprints
    class InstalledPackagesController < BaseController

      def update
        @app.blueprint.installed_packages.update strong_params
        # render 'apps/blueprints/jsons/refresh'
      end

      def new
        @app.blueprint.installed_packages.build_installed_package
        # render 'apps/blueprints/installed_packages/new'
      end

      def destroy
        @app.blueprint.installed_packages.delete(params[:id].to_i)
        # render 'apps/blueprints/installed_packages/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_installed_packages).
          permit( installed_packages_attributes: [ :name, :source_url, :destination, :extraction_command, :path_to_extracted ] )
      end

    end
  end
end
