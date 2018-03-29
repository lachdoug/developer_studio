module Services
  module Blueprints
    class BasesController < BaseController

      def update
        @service.blueprint.base.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_base).
          permit( :name,
                  :inherit,
                  :cardinal,
                  :publisher_namespace,
                  :type_path,
                  :service_handle_field,
                  :parent_image,
                  :deployment_type,
                  :http_protocol,
                  :hostname,
                  :domain_name,
                  :set_state,
                  :default_stop_timeout,
                  :restart_policy,
                  :restart_attempts,
                  :memory_required,
                  :memory_recommended,
                  :run_as_user,
                  :user_id,
                  :user_primary_group,
                  :create_user,
                  :source_files,
                )
      end

    end
  end
end
