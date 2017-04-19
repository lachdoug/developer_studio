module Services
  module Blueprints
    module Actionators
      module Variables
        class MoveupsController < BaseController

          def show
            @actionator = @service.blueprint.actionators.find params[:actionator_id]
            @actionator.variables.moveup params[:variable_id]
            render
          end

        end
      end
    end
  end
end
