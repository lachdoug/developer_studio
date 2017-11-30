module Services
  module Blueprints
    class LogDirectoriesController < BaseController

      def update
        @log_directory = @service.blueprint.log_directories.find params[:id]
        @log_directory.update strong_params
        render
      end

      def new
        @service.blueprint.log_directories.build
        render
      end

      def destroy
        @service.blueprint.log_directories.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_log_directory).
          permit( :path )
      end

    end
  end
end
