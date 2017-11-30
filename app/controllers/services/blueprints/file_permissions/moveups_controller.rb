module Services
  module Blueprints
    module FilePermissions
      class MoveupsController < BaseController

        def show
          @service.blueprint.file_permissions.moveup params[:file_permission_id]
          render
        end

      end
    end
  end
end
