module Services
  module Blueprints
    module Schedules
      class VariablesController < BaseController

        def new
          # if
            @schedule = @service.blueprint.schedules.find(params[:schedule_id])
            @schedule.load_variables_from_blueprint_actionator
            render
          #   render 'services/blueprints/schedules/update'
          # else
          #   render 'update_fail'
          # end
        end

      end
    end
  end
end
