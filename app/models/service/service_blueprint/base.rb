class Service
  class ServiceBlueprint
    class Base < ::Blueprint::Section

      attr_accessor :name,
                    :deployment_type,
                    :http_protocol,
                    :memory_required,
                    :memory_recommended

      def build_section
        @name = ( data || {} ).dig :name
        @deployment_type = ( data || {} ).dig :deployment_type
        @http_protocol = ( data || {} ).dig :http_protocol
        @memory_required = ( data || {} ).dig :memory, :required
        @memory_recommended = ( data || {} ).dig :memory, :recommended
      end

      def form_data
        {
          name: name,
          deployment_type: deployment_type,
          http_protocol: ( http_protocol if deployment_type == 'web' ).to_s,
          memory: {
            required: memory_required,
            recommended: memory_recommended
          }
        }
      end

      def frameworks_collection
        dropdowns_config[:frameworks]
      end

      def types_collection
        [:web, :worker]
      end

      def http_protocol_collection
        { "HTTPS and HTTP": :https_and_http,
          "HTTP and HTTPS": :http_and_https,
          "HTTPS only": :https_only,
          "HTTP only": :http_only }
      end

    end
  end
end
