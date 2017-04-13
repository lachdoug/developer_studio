module Apps
  module Blueprints
    module Actionators
      module Variables
        class MoveupsController < BaseController

          def show
            @actionator = @app.blueprint.actionators.find params[:actionator_id]
            @actionator.variables.moveup params[:variable_id]
            render
          end

        end
      end
    end
  end
end
