module Services
  module Blueprints
    class FilePermissionsController < BaseController

      def update
        @file_permission = @service.blueprint.file_permissions.find params[:id]
        @file_permission.update strong_params
        render
      end

      def new
        @service.blueprint.file_permissions.build
        render
      end

      def destroy
        @service.blueprint.file_permissions.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_file_permission).
          permit( :path, :recursive, :user, :group, :permissions )
      end

    end
  end
end
