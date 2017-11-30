module Services
  module Blueprints
    class DispositionsController < BaseController

      def update
        @service.blueprint.disposition.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_disposition).
          permit( :dedicated,
                  :persistent,
                  :immutable,
                  :attach_post_build,
                  :attach_requires_restart,
                  :soft_service,
                  :shareable,
                  :consumer_exportable,
                  :stopped_ok,
                  :kerberos_support,
                  :host_network,
                  :privileged,
                  :no_ca_map,
                  :consumerless,
                  :start_syslog )
      end

    end
  end
end
