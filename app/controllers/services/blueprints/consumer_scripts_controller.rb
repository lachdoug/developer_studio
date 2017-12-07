module Services
  module Blueprints
    class ConsumerScriptsController < BaseController

      def update
        # byebug
        @service.blueprint.consumer_scripts.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_consumer_scripts).
          permit( add_script_attributes: [:language, :content],
                  add_script_sudo_attributes: [:language, :content],
                  remove_script_attributes: [:language, :content],
                  remove_script_sudo_attributes: [:language, :content],
                  update_script_attributes: [:language, :content],
                  update_script_sudo_attributes: [:language, :content] )
      end

    end
  end
end
