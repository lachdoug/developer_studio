module Services
  module Blueprints
    module EnvironmentVariables
      class MoveupsController < BaseController

        def show
          @service.blueprint.environment_variables.moveup params[:environment_variable_id]
          render
        end

      end
    end
  end
end
