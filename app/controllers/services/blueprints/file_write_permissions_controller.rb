module Services
  module Blueprints
    class FileWritePermissionsController < BaseController

      def update
        @file_write_permission = @service.blueprint.file_write_permissions.find params[:id]
        @file_write_permission.update strong_params
        render
      end

      def new
        @service.blueprint.file_write_permissions.build
        render
      end

      def destroy
        @service.blueprint.file_write_permissions.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_file_write_permission).
          permit( :path, :recursive )
      end

    end
  end
end
