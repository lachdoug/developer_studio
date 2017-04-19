module Services
  module Blueprints
    module Actionators
      module Variables
        module Inputs
          module Collections
            module Items
              class MoveupsController < BaseController

                def show
                  @actionator = @service.blueprint.actionators.find params[:actionator_id]
                  @variable = @actionator.variables.find params[:variable_id]
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
