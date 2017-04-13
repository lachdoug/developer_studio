module Apps
  module Blueprints
    module ServiceConfigurations
      class MoveupsController < BaseController

        def show
          @app.blueprint.service_configurations.moveup params[:service_configuration_id]
          render
        end

      end
    end
  end
end
