module Apps
  module Blueprints
    class ActionatorsController < BaseController

      def update
        @actionator = @app.blueprint.actionators.find params[:id]
        # get associated schedules to refresh
        @actionator_schedules = associated_schedules
        @actionator.update strong_params
        render
      end

      def new
        @app.blueprint.actionators.build
        render
      end

      def destroy
        @actionator = @app.blueprint.actionators.find params[:id]
        @actionator_schedules = associated_schedules
        @app.blueprint.actionators.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_actionator).
          permit( :name,
                  :label,
                  :description,
                  :return_type,
                  :return_file_name,
                  :enable_logging,
                  script_attributes: [:language, :content],
                )
      end

      def associated_schedules
        @app.blueprint.schedules.select{ |schedule| schedule.actionator_name == @actionator.name }
      end

    end
  end
end
