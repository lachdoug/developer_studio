module Apps
  module Blueprints
    class InstalledPackagesController < BaseController

      def update
        @installed_package = @app.blueprint.installed_packages.find params[:id]
        @installed_package.update strong_params
        render
      end

      def new
        @app.blueprint.installed_packages.build
        render
      end

      def destroy
        @app.blueprint.installed_packages.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_installed_package).
          permit(
            :name,
            :download_type,
            :source_url,
            :destination,
            :extraction_command,
            :command_options,
            :path_to_extracted,
            :authentication
          )
      end

    end
  end
end
