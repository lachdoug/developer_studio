module Services
  module Blueprints
    module ApacheHttpdConfigurations
      class MoveupsController < BaseController

        def show
          @service.blueprint.apache_httpd_configurations.moveup params[:apache_httpd_configuration_id]
          render
        end

      end
    end
  end
end
