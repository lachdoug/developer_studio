module Services
  module Blueprints
    module InstalledPackages
      class MoveupsController < BaseController

        def show
          @service.blueprint.installed_packages.moveup params[:installed_package_id]
          render
        end

      end
    end
  end
end
