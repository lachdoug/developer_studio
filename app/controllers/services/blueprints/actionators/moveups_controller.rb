module Services
  module Blueprints
    module Actionators
      class MoveupsController < BaseController

        def show
          @service.blueprint.actionators.moveup params[:actionator_id]
          render
        end

      end
    end
  end
end
