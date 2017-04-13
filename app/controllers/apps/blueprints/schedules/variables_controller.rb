module Apps
  module Blueprints
    module Schedules
      class VariablesController < BaseController

        def new
          # if
            @schedule = @app.blueprint.schedules.find(params[:schedule_id])
            @schedule.load_variables_from_blueprint_actionator
            render
          #   render 'apps/blueprints/schedules/update'
          # else
          #   render 'update_fail'
          # end
        end

      end
    end
  end
end
