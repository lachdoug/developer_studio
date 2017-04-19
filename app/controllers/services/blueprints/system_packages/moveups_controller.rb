module Services
  module Blueprints
    module SystemPackages
      class MoveupsController < BaseController

        def show
          @service.blueprint.system_packages.moveup params[:system_package_id]
          render
        end

      end
    end
  end
end
