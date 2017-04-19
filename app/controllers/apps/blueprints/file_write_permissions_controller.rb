module Apps
  module Blueprints
    class FileWritePermissionsController < BaseController

      def update
        @file_write_permission = @app.blueprint.file_write_permissions.find params[:id]
        @file_write_permission.update strong_params
        render
      end

      def new
        @app.blueprint.file_write_permissions.build
        render
      end

      def destroy
        @app.blueprint.file_write_permissions.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_file_write_permission).
          permit( :path, :recursive )
      end

    end
  end
end
