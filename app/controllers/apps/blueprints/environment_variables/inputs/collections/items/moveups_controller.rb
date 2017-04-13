module Apps
  module Blueprints
    module EnvironmentVariables
      module Inputs
        module Collections
          module Items
            class MoveupsController < BaseController

              def show
                @environment_variable = @app.blueprint.environment_variables.find params[:environment_variable_id]
                @environment_variable.input.collection.moveup params[:item_id]
                render
              end

            end
          end
        end
      end
    end
  end
end
