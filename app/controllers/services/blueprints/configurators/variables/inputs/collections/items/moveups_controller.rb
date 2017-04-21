module Services
  module Blueprints
    module Configurators
      module Variables
        module Inputs
          module Collections
            module Items
              class MoveupsController < BaseController

                def show
                  @configurator = @service.blueprint.configurators.find params[:configurator_id]
                  @variable = @configurator.variables.find params[:variable_id]
                  @variable.input.collection.moveup params[:item_id]
                  render
                end

              end
            end
          end
        end
      end
    end
  end
end
