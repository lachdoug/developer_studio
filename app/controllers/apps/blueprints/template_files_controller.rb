module Apps
  module Blueprints
    class TemplateFilesController < BaseController

      def update
        @app.blueprint.template_files.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.template_files.build_template_file
        render 'apps/blueprints/template_files/update'
      end

      def destroy
        @app.blueprint.template_files.delete(params[:id].to_i)
        render 'apps/blueprints/template_files/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_template_files).
          permit( template_files_attributes: [ :path, :language, :content ] )
      end

    end
  end
end
