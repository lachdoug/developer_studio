module Services
  module Blueprints
    module Bases
      class AcceptsController < BaseController

        def update
          @accept = @service.blueprint.base.accepts.find params[:id]
          @accept.update strong_params
          render
        end

        def new
          @service.blueprint.base.accepts.build
          render
        end

        def destroy
          @service.blueprint.base.accepts.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:service_service_blueprint_base_accept).
            permit( :type )
        end

      end
    end
  end
end
