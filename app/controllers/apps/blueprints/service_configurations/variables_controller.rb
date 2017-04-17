module Apps
  module Blueprints
    module ServiceConfigurations
      class VariablesController < BaseController

        def new
          @service_configuration = @app.blueprint.service_configurations.find(params[:service_configuration_id])
          @service_configuration.load_variables
          render
        end

      end
    end
  end
end
