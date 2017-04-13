module Apps
  module Blueprints
    class ApacheHtaccessFilesController < BaseController

      def update
        @apache_htaccess_file = @app.blueprint.apache_htaccess_files.find params[:id]
        @apache_htaccess_file.update strong_params
        render
      end

      def new
        @app.blueprint.apache_htaccess_files.build
        render
      end

      def destroy
        @app.blueprint.apache_htaccess_files.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_apache_htaccess_file).
          permit( :directory, :content )
      end

    end
  end
end
