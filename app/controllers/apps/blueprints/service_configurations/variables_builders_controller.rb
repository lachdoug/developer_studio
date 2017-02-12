module Apps
  module Blueprints
    module ServiceConfigurations
      class VariablesBuildersController < BaseController

        def new
          if @app.blueprint.service_configurations.find(params[:id]).load_variables_from_service_definition
            render 'apps/blueprints/service_configurations/update'
          else
            render 'update_fail'
          end
        end

      end
    end
  end
end
