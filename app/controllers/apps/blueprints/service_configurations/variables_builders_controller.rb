module Apps
  module Blueprints
    module ServiceConfigurations
      class VariablesBuildersController < BaseController

        def new
          @service_configuration = @app.blueprint.service_configurations.find(params[:id])
          if @service_configuration.load_variables_from_service_definition
            render 'apps/blueprints/service_configurations/update', service_configuration: @service_configuration, service_configuration_id: params[:id]
          else
            render 'update_fail'
          end
        end

      end
    end
  end
end
