module Apps
  module Blueprints
    class ApacheHttpdConfigurationsController < BaseController

      def update
        @app.blueprint.apache_httpd_configurations.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.apache_httpd_configurations.build_apache_httpd_configuration
        render 'apps/blueprints/apache_httpd_configurations/update'
      end

      def destroy
        @app.blueprint.apache_httpd_configurations.delete(params[:id].to_i)
        render 'apps/blueprints/apache_httpd_configurations/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_apache_httpd_configurations).
          permit( apache_httpd_configurations_attributes: [ :content ] )
      end

    end
  end
end
