module Apps
  module Blueprints
    module Actionators
      class MoveupsController < BaseController

        def show
          @app.blueprint.actionators.moveup params[:actionator_id]
          render
        end

      end
    end
  end
end
