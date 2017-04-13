module Apps
  module Blueprints
    module PersistentFiles
      class MoveupsController < BaseController

        def show
          @app.blueprint.persistent_files.moveup params[:persistent_file_id]
          render
        end

      end
    end
  end
end
