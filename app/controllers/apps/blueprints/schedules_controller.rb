module Apps
  module Blueprints
    class SchedulesController < BaseController

      def update
        @schedule = @app.blueprint.schedules.find(params[:id])
        blueprint_section_view_requires_refresh = schedule_actionator_name_set || schedule_instruction_changed
        @schedule.update(strong_params)
        if blueprint_section_view_requires_refresh
          render 'apps/blueprints/schedules/update'
        else
          render 'apps/blueprints/jsons/update'
        end
      end

      def new
        @app.blueprint.schedules.build
        render 'apps/blueprints/schedules/update'
      end

      def destroy
        @app.blueprint.schedules.delete(params[:id])
        render 'apps/blueprints/schedules/update'
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

      # def

      def schedule_actionator_name_set
        @schedule.actionator_name != strong_params[:actionator_name]
      end

      def schedule_instruction_changed
        @schedule.instruction != strong_params[:instruction]
      end

    end
  end
end
