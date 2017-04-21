module Services
  module Blueprints
    module Configurators
      module Variables
        class MoveupsController < BaseController

          def show
            @configurator = @service.blueprint.configurators.find params[:configurator_id]
            @configurator.variables.moveup params[:variable_id]
            render
          end

        end
      end
    end
  end
end
