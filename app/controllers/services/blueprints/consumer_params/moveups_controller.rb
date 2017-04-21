module Services
  module Blueprints
    module ConsumerParams
      class MoveupsController < BaseController

        def show
          @service.blueprint.consumer_params.moveup params[:consumer_param_id]
          render
        end

      end
    end
  end
end
