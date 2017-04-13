module Apps
  module Blueprints
    module PersistentDirectories
      class MoveupsController < BaseController

        def show
          @app.blueprint.persistent_directories.moveup params[:persistent_directory_id]
          render
        end

      end
    end
  end
end
