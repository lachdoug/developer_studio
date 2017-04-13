module Apps
  module Blueprints
    module ServiceConfigurations
      class VariablesController < BaseController

        def new
          @app.blueprint.service_configurations.load_variables_for(params[:service_configuration_id])
          @service_configuration = @app.blueprint.service_configurations.find(params[:service_configuration_id])
          # byebug
          render
          # @service_configuration =

          # if @service_configuration.load_variables
            # render 'apps/blueprints/service_configurations/variables/new'
          # else
            # render 'update_fail'
          # end
        end

      end
    end
  end
end
