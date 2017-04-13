module Apps
  module Blueprints
    module Schedules
      class MoveupsController < BaseController

        def show
          @app.blueprint.schedules.moveup params[:schedule_id]
          render
        end

      end
    end
  end
end
