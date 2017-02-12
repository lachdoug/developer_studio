module Apps
  module Blueprints
    class PersistentFilesController < BaseController

      def update
        @app.blueprint.persistent_files.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.persistent_files.build_persistent_file
        render 'apps/blueprints/persistent_files/update'
      end

      def destroy
        @app.blueprint.persistent_files.delete(params[:id].to_i)
        render 'apps/blueprints/persistent_files/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_persistent_files).
          permit( persistent_files_attributes: [ :path ] )
      end

    end
  end
end
