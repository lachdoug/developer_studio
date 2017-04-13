module Apps
  module Blueprints
    class PersistentDirectoriesController < BaseController

      def update
        @app.blueprint.persistent_directories.update strong_params
        render 'apps/blueprints/jsons/refresh'
      end

      def new
        @app.blueprint.persistent_directories.build_persistent_directory
        render 'apps/blueprints/persistent_directories/update'
      end

      def destroy
        @app.blueprint.persistent_directories.delete(params[:id].to_i)
        render 'apps/blueprints/persistent_directories/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_persistent_directories).
          permit( persistent_directories_attributes: [ :path ] )
      end

    end
  end
end
