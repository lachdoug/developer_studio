module Apps
  module Blueprints
    module Actionators
      module Variables
        module Inputs
          module Collections
            class ItemsController < BaseController

              def new
                @actionator = @app.blueprint.actionators.find params[:actionator_id]
                @variable = @actionator.variables.find params[:variable_id]
                @variable.input.collection.build
                render
              end

              def destroy
                @actionator = @app.blueprint.actionators.find params[:actionator_id]
                # get associated schedules to refresh
                @actionator_schedules = associated_schedules
                @variable = @actionator.variables.find params[:variable_id]
                @variable.input.collection.delete params[:id]
                render
              end

              private

              def associated_schedules
                @app.blueprint.schedules.select{ |schedule| schedule.actionator_name == @actionator.name }
              end

            end
          end
        end
      end
    end
  end
end
