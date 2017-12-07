module Services
  module Blueprints
    class ConfiguratorsController < BaseController

      def update
        @configurator = @service.blueprint.configurators.find params[:id]
        @configurator.update strong_params
        render
      end

      def new
        @service.blueprint.configurators.build
        render
      end

      def destroy
        @configurator = @service.blueprint.configurators.find params[:id]
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
                  set_script_sudo_attributes: [:language, :content],
                  read_script_attributes: [:language, :content],
                  read_script_sudo_attributes: [:language, :content],
                )
      end

    end
  end
end
