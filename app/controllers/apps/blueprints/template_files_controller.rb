module Apps
  module Blueprints
    class TemplateFilesController < BaseController

      def update
        @template_file = @app.blueprint.template_files.find params[:id]
        @template_file.update strong_params
        render
      end

      def new
        @app.blueprint.template_files.build
        render
      end

      def destroy
        @app.blueprint.template_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_template_file).
          permit( :path, :content, :language )
      end

    end
  end
end
