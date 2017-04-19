module Services
  module Blueprints
    class ApacheHttpdConfigurationsController < BaseController

      def update
        @apache_httpd_configuration = @service.blueprint.apache_httpd_configurations.find params[:id]
        @apache_httpd_configuration.update strong_params
        render
      end

      def new
        @service.blueprint.apache_httpd_configurations.build
        render
      end

      def destroy
        @service.blueprint.apache_httpd_configurations.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_apache_httpd_configuration).
          permit( :content )
      end

    end
  end
end
