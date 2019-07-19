module Apps
  module Blueprints
    class ScriptsController < BaseController

      def update
        @app.blueprint.scripts.update strong_params
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_scripts).
          permit( start_attributes: [:language, :content],
                  install_attributes: [:language, :content],
                  first_run_attributes: [:language, :content],
                  post_install_attributes: [:language, :content],
                  backup_attributes: [:language, :content],
                  restore_attributes: [:language, :content],
                  shutdown_attributes: [:language, :content] )
      end

    end
  end
end
