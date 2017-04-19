module Services
  module Blueprints
    class PersistentDirectoriesController < BaseController

      def update
        @persistent_directory = @service.blueprint.persistent_directories.find params[:id]
        @persistent_directory.update strong_params
        render
      end

      def new
        @service.blueprint.persistent_directories.build
        render
      end

      def destroy
        @service.blueprint.persistent_directories.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_persistent_directory).
          permit( :path )
      end

    end
  end
end
