module Apps
  module Blueprints
    module ServiceConfigurations
      class TypePathsController < BaseController

        def create
          @app.blueprint.service_configurations.build strong_params
          @app.blueprint.service_configurations.load_variables_for(params[:service_configuration_id])
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
