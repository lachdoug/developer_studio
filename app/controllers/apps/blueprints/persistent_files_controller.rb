module Apps
  module Blueprints
    class PersistentFilesController < BaseController

      def update
        @persistent_file = @app.blueprint.persistent_files.find params[:id]
        @persistent_file.update strong_params
        render
      end

      def new
        @app.blueprint.persistent_files.build
        render
      end

      def destroy
        @app.blueprint.persistent_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_persistent_file).
          permit( :path )
      end

    end
  end
end
