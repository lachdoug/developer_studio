module Services
  module Blueprints
    class ScriptsController < BaseController

      def update
        @service.blueprint.scripts.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_scripts).
          permit( start_attributes: [:language, :content],
                  install_attributes: [:language, :content],
                  post_install_attributes: [:language, :content],
                  shutdown_attributes: [:language, :content] )
      end

    end
  end
end
