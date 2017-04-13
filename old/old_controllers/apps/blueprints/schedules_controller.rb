module Apps
  module Blueprints
    class SchedulesController < BaseController

      def update
        @schedule = @app.blueprint.schedules.find(params[:id])
        @schedule.update(strong_params)
        render 'apps/blueprints/schedules/update'
      end

      def new
        @app.blueprint.schedules.build
        render 'apps/blueprints/schedules/new'
      end

      def destroy
        @app.blueprint.schedules.delete(params[:id])
        render 'apps/blueprints/schedules/destroy'
      end

      private

      def strong_params
        params.require(:app_blueprint_schedules_schedule).
          permit( :label,
                :timespec_minute,
                :timespec_hour,
                :timespec_day_of_month,
                :timespec_month,
                :timespec_day_of_week,
                :instruction,
                :actionator_name,
                { variables_attributes: [:name, :value, :resolve_string, :resolve] } )
      end

    end
  end
end
