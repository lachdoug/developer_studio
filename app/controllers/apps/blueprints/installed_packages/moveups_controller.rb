module Apps
  module Blueprints
    module InstalledPackages
      class MoveupsController < BaseController

        def show
          @app.blueprint.installed_packages.moveup params[:installed_package_id]
          render
        end

      end
    end
  end
end
