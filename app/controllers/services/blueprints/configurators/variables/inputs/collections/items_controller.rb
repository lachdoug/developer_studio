module Services
  module Blueprints
    module Configurators
      module Variables
        module Inputs
          module Collections
            class ItemsController < BaseController

              def new
                @configurator = @service.blueprint.configurators.find params[:configurator_id]
                @variable = @configurator.variables.find params[:variable_id]
                @variable.input.collection.build
                render
              end

              def destroy
                @configurator = @service.blueprint.configurators.find params[:configurator_id]
                # get associated schedules to refresh
                @configurator_schedules = associated_schedules
                @variable = @configurator.variables.find params[:variable_id]
                @variable.input.collection.delete params[:id]
                render
              end

              private

              def associated_schedules
                @service.blueprint.schedules.select{ |schedule| schedule.configurator_name == @configurator.name }
              end

            end
          end
        end
      end
    end
  end
end
