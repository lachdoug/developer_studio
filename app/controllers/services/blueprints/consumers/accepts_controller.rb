module Services
  module Blueprints
    module Consumers
      class AcceptsController < ConsumersController

        def update
          @accept = @service.blueprint.consumers.accepts.find params[:id]
          @accept.update strong_params
          render
        end

        def new
          @service.blueprint.consumers.accepts.build
          render
        end

        def destroy
          @service.blueprint.consumers.accepts.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:service_service_blueprint_consumers_accept).
            permit( :type )
        end

      end
    end
  end
end
