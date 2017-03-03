module Apps
  module Blueprints
    class ApacheHtaccessFilesController < BaseController

      def update
        @app.blueprint.apache_htaccess_files.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.apache_htaccess_files.build_apache_htaccess_file
        render 'apps/blueprints/apache_htaccess_files/update'
      end

      def destroy
        @app.blueprint.apache_htaccess_files.delete(params[:id].to_i)
        render 'apps/blueprints/apache_htaccess_files/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_apache_htaccess_files).
          permit( apache_htaccess_files_attributes: [ :directory, :content ] )
      end

    end
  end
end
