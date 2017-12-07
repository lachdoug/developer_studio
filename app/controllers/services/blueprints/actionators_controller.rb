module Services
  module Blueprints
    class ActionatorsController < BaseController

      def update
        @actionator = @service.blueprint.actionators.find params[:id]
        # get associated schedules to refresh
        @actionator_schedules = associated_schedules
        @actionator.update strong_params
        render
      end

      def new
        @service.blueprint.actionators.build
        render
      end

      def destroy
        @actionator = @service.blueprint.actionators.find params[:id]
        @actionator_schedules = associated_schedules
        @service.blueprint.actionators.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_actionator).
          permit( :name,
                  :label,
                  :description,
                  :return_type,
                  :return_file_name,
                  :enable_logging,
                  script_attributes: [:language, :content],
                  script_sudo_attributes: [:language, :content]
                )
      end

      def associated_schedules
        # get schedules using current name and new name, so that all schedules impacted by name change can be refreshed
        @service.blueprint.schedules.select{ |schedule| ( schedule.actionator_name == @actionator.name ) || ( schedule.actionator_name == strong_params[:name] ) }
      end

    end
  end
end
