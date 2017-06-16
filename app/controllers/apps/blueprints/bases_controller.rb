module Apps
  module Blueprints
    class BasesController < BaseController

      def update
        @app.blueprint.base.update strong_params
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_base).
          permit( :name,
                  accepts: [ :type ],
                  :publisher_namespace,
                  :type_path,
                  :service_handle_field,
                  :framework,
                  :parent_image,
                  :run_as_user,
                  :memory_required,
                  :memory_recommended,
                  :http_protocol,
                  :framework_port_override,
                  :deployment_type,
                  :web_root_directory,
                  :continuous_deployment,
                  :install_form_comment,
                  :first_run_url,
                  :installation_report )
      end

    end
  end
end
