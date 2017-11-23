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
                  :publisher_namespace,
                  :type_path,
                  :service_handle_field,
                  :parent_image,
                  :run_as_user,
                  :deployment_type,
                  :http_protocol,
                  :memory_required,
                  :memory_recommended,
                  :dedicated,
                  :persistent,
                  :immutable,
                  :attach_post_build,
                  :attach_requires_restart,
                  :soft_service,
                  :shareable,
                  :consumer_exportable )
      end

    end
  end
end
