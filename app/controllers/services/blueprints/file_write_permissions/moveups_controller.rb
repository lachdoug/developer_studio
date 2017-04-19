module Services
  module Blueprints
    module FileWritePermissions
      class MoveupsController < BaseController

        def show
          @service.blueprint.file_write_permissions.moveup params[:file_write_permission_id]
          render
        end

      end
    end
  end
end
