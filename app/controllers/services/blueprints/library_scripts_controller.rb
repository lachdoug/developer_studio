module Services
  module Blueprints
    class LibraryScriptsController < BaseController

      def update
        @library_script = @service.blueprint.library_scripts.find params[:id]
        @library_script.update strong_params
        render
      end

      def new
        @service.blueprint.library_scripts.build
        render
      end

      def destroy
        @service.blueprint.library_scripts.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_library_script).
          permit( :name, :language, :content, :sudo )
      end

    end
  end
end
