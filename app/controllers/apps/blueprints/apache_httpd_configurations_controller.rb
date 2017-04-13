module Apps
  module Blueprints
    class ApacheHttpdConfigurationsController < BaseController

      def update
        @apache_httpd_configuration = @app.blueprint.apache_httpd_configurations.find params[:id]
        @apache_httpd_configuration.update strong_params
        render
      end

      def new
        @app.blueprint.apache_httpd_configurations.build
        render
      end

      def destroy
        @app.blueprint.apache_httpd_configurations.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_apache_httpd_configuration).
          permit( :content )
      end

    end
  end
end
