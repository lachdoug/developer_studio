module Apps
  module Blueprints
    class PersistentDirectoriesController < BaseController

      def update
        @persistent_directory = @app.blueprint.persistent_directories.find params[:id]
        @persistent_directory.update strong_params
        render
      end

      def new
        @app.blueprint.persistent_directories.build
        render
      end

      def destroy
        @app.blueprint.persistent_directories.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_persistent_directory).
          permit( :path )
      end

    end
  end
end
