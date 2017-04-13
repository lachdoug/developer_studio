module Apps
  module Blueprints
    class FileWritePermissionsController < BaseController

      def update
        @app.blueprint.file_write_permissions.update strong_params
        render 'apps/blueprints/jsons/refresh'
      end

      def new
        @app.blueprint.file_write_permissions.build_file_write_permission
        render 'apps/blueprints/file_write_permissions/update'
      end

      def destroy
        @app.blueprint.file_write_permissions.delete(params[:id].to_i)
        render 'apps/blueprints/file_write_permissions/update'
      end


      private

      def strong_params
        params.require(:app_blueprint_file_write_permissions).
          permit( file_write_permissions_attributes: [ :path, :recursive ] )
      end

    end
  end
end
