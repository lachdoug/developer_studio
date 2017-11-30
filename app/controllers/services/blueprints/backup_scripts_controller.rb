module Services
  module Blueprints
    class BackupScriptsController < BaseController

      def update
        # byebug
        @service.blueprint.backup_scripts.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_backup_scripts).
          permit( backup_script_attributes: [:language, :content],
                  restore_script_attributes: [:language, :content] )
      end

    end
  end
end
