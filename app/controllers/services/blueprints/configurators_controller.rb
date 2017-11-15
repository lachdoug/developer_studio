module Services
  module Blueprints
    class ConfiguratorsController < BaseController

      def update
        @configurator = @service.blueprint.configurators.find params[:id]
        # get associated schedules to refresh
        @configurator_schedules = associated_schedules
        @configurator.update strong_params
        render
      end

      def new
        @service.blueprint.configurators.build
        render
      end

      def destroy
        @configurator = @service.blueprint.configurators.find params[:id]
        @configurator_schedules = associated_schedules
        @service.blueprint.configurators.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_configurator).
          permit( :name,
                  :label,
                  :description,
                  :enable_logging,
                  :no_save,
                  set_script_attributes: [:language, :content],
                  read_script_attributes: [:language, :content]
                )
      end

      def associated_schedules
        @service.blueprint.schedules.select{ |schedule| schedule.configurator_name == @configurator.name }
      end

    end
  end
end
