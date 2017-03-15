module Apps
  module Blueprints
    class TemplateFilesController < BaseController

      def update
        # new_blueprint_template_file = @app.blueprint.template_files.template_files.last.new_record?
        @app.blueprint.template_files.update(strong_params)
        # if new_blueprint_template_file
          # render 'apps/blueprints/template_files/new'
        # else
          render 'apps/blueprints/jsons/update'
        # end
      end

      def new
        @app.blueprint.template_files.build_template_file
        render 'apps/blueprints/template_files/new'
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
