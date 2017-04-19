module Services
  module Blueprints
    class BasesController < BaseController

      def update
        @service.blueprint.base.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_base).
          permit( :name,
                  :framework,
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