module Services
  module Blueprints
    class TemplateFilesController < BaseController

      def update
        @template_file = @service.blueprint.template_files.find params[:id]
        @template_file.update strong_params
        render
      end

      def new
        @service.blueprint.template_files.build
        render
      end

      def destroy
        @service.blueprint.template_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_template_file).
          permit( :path, :content, :language, :preprocess, :user, :group, :permissions )
      end

    end
  end
end
