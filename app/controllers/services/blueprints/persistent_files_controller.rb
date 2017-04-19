module Services
  module Blueprints
    class PersistentFilesController < BaseController

      def update
        @persistent_file = @service.blueprint.persistent_files.find params[:id]
        @persistent_file.update strong_params
        render
      end

      def new
        @service.blueprint.persistent_files.build
        render
      end

      def destroy
        @service.blueprint.persistent_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_persistent_file).
          permit( :path )
      end

    end
  end
end
