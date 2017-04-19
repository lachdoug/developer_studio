module Services
  module Blueprints
    module Schedules
      class MoveupsController < BaseController

        def show
          @service.blueprint.schedules.moveup params[:schedule_id]
          render
        end

      end
    end
  end
end
