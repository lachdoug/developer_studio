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
                @variable = @configurator.variables.find params[:variable_id]
                @variable.input.collection.delete params[:id]
                render
              end

            end
          end
        end
      end
    end
  end
end
