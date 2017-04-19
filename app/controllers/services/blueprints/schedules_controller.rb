module Services
  module Blueprints
    class SchedulesController < BaseController

      def update
        @schedule = @service.blueprint.schedules.find params[:id]
        @schedule.update strong_params
        render
      end

      def new
        # byebug
        @service.blueprint.schedules.build
        render
      end

      def destroy
        @service.blueprint.schedules.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_schedule).
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
