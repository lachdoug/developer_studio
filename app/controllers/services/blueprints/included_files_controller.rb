module Services
  module Blueprints
    class IncludedFilesController < BaseController

      def update
        @included_file = @service.blueprint.included_files.find params[:id]
        @included_file.update strong_params
        render
      end

      def new
        @service.blueprint.included_files.build
        render
      end

      def destroy
        @service.blueprint.included_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_included_file).
          permit( :source, :destination, :template, :owner, :group, :permissions )
      end

    end
  end
end
