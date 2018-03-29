module Services
  module Blueprints
    class CustomFilesController < BaseController

      def update
        @custom_file = @service.blueprint.custom_files.find params[:id]
        @custom_file.update strong_params
        render
      end

      def new
        @service.blueprint.custom_files.build
        render
      end

      def destroy
        @service.blueprint.custom_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_custom_file).
          permit( :path, :content, :language, :type, :execute, :sudo )
      end

    end
  end
end
