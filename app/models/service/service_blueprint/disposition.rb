class Service
  class ServiceBlueprint
    class Disposition < ::Blueprint::Section

      attr_accessor :dedicated,
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
                    :start_syslog

      def build_section
        # p :success
        # byebzzzzzzzzzzzzzzzzzzzzzzzug
        @dedicated = ( data || {} ).dig :dedicated
        @persistent = ( data || {} ).dig :persistent
        @immutable = ( data || {} ).dig :immutable
        @attach_post_build = ( data || {} ).dig :attach_post_build
        @attach_requires_restart = ( data || {} ).dig :attach_requires_restart
        @soft_service = ( data || {} ).dig :soft_service
        @shareable = ( data || {} ).dig :shareable
        @consumer_exportable = ( data || {} ).dig :consumer_exportable
        @stopped_ok = ( data || {} ).dig :stopped_ok
        @kerberos_support = ( data || {} ).dig :kerberos_support
        @host_network = ( data || {} ).dig :host_network
        @privileged = ( data || {} ).dig :privileged
        @no_ca_map = ( data || {} ).dig :no_ca_map
        @consumerless = ( data || {} ).dig :consumerless
        @start_syslog = ( data || {} ).dig :start_syslog
      end

      def form_data
        {
          dedicated: dedicated,
          persistent: persistent,
          immutable: immutable,
          attach_post_build: attach_post_build,
          attach_requires_restart: attach_requires_restart,
          soft_service: soft_service,
          shareable: shareable,
          consumer_exportable: consumer_exportable,
          stopped_ok: stopped_ok,
          kerberos_support: kerberos_support,
          host_network: host_network,
          privileged: privileged,
          no_ca_map: no_ca_map,
          consumerless: consumerless,
          start_syslog: start_syslog,
        }
      end

    end
  end
end
