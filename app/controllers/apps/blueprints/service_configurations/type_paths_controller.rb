module Apps
  module Blueprints
    module ServiceConfigurations
      class TypePathsController < BaseController

        def create
          @service_configuration = @app.blueprint.service_configurations.build strong_params
          @service_configuration.load_variables
          render
        end

        private

        def strong_params
          params.require(:app_blueprint_service_configuration).
            permit( :publisher_namespace,
                    :type_path )
        end

      end
    end
  end
end
