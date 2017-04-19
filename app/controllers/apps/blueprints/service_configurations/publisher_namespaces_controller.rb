module Apps
  module Blueprints
    module ServiceConfigurations
      class PublisherNamespacesController < BaseController

        def create
          @service_configuration = @app.blueprint.service_configurations.build strong_params
          render
        end

        private

        def strong_params
          params.require(:app_app_blueprint_service_configuration).
            permit( :publisher_namespace )
        end

      end
    end
  end
end
