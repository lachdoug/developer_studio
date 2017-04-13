module Apps
  module Blueprints
    module EnvironmentVariables
      class MoveupsController < BaseController

        def show
          @app.blueprint.environment_variables.moveup params[:environment_variable_id]
          render
        end

      end
    end
  end
end
