module Services
  module Blueprints
    module Consumers
      module Accepts
        class MoveupsController < ConsumersController

          def show
            @service.blueprint.consumers.accepts.moveup params[:accept_id]
            render
          end

        end
      end
    end
  end
end
