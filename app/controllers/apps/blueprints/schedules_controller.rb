module Apps
  module Blueprints
    class SchedulesController < BaseController

      def update
        @schedule = @app.blueprint.schedules.find params[:id]
        @schedule.update strong_params
        render
      end

      def new
        # byebug
        @app.blueprint.schedules.build
        render
      end

      def destroy
        @app.blueprint.schedules.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_schedule).
          permit( :label,
                  :timespec_minute,
                  :timespec_hour,
                  :timespec_day_of_month,
                  :timespec_month,
                  :timespec_day_of_week,
                  :instruction,
                  :actionator_name,
                  { variables_attributes:
                    [:name, :value, :resolve_string, :resolve] } )
      end

    end
  end
end
