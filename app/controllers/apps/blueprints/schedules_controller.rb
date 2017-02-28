module Apps
  module Blueprints
    class SchedulesController < BaseController

      def update
        @app.blueprint.schedules.find(params[:id]).update(strong_params)
        render 'apps/blueprints/jsons/update'
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
          permit( :namespace,
                :type_path,
                { variables_attributes: [:name, :value, :resolve_string, :resolve] } )
      end

      def schedules_incomplete
        @app.blueprint.schedules.all.map{ |schedule| schedule.type_path.blank? }.any?
      end

      def schedule_creation
        @app.blueprint.schedules.all.count == params[:id].to_i
      end

    end
  end
end
