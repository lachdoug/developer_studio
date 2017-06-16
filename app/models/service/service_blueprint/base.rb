class Service
  class ServiceBlueprint
    class Base < ::Blueprint::Section

      attr_accessor :name,
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
                    :soft_service
      attr_reader :accepts

      def build_section
        @name = ( data || {} ).dig :name
        @publisher_namespace= ( data || {} ).dig :publisher_namespace
        @type_path= ( data || {} ).dig :type_path
        @service_handle_field= ( data || {} ).dig :service_handle_field
        @parent_image = ( data || {} ).dig :parent_image
        @run_as_user = ( data || {} ).dig :run_as_user
        @deployment_type = ( data || {} ).dig :deployment_type
        @http_protocol = ( data || {} ).dig :http_protocol
        @memory_required = ( data || {} ).dig :memory, :required
        @memory_recommended = ( data || {} ).dig :memory, :recommended
        @dedicated = ( data || {} ).dig :dedicated
        @persistent = ( data || {} ).dig :persistent
        @immutable = ( data || {} ).dig :immutable
        @attach_post_build = ( data || {} ).dig :attach_post_build
        @attach_requires_restart = ( data || {} ).dig :attach_requires_restart
        @soft_service = ( data || {} ).dig :soft_service
        self.accepts_attributes = accepts_collection_data
      end

      def accepts_collection_data
        ( ( data || {} ).dig( :accepts ) || [] ).map.with_index do |accept, i|
          { i => { type: accept } }
        end.inject(:merge) || {}
      end

      def accepts_attributes=(params)
        @accepts = Accepts.new self, params
      end

      def form_data
        {
          name: name,
          publisher_namespace: publisher_namespace,
          type_path: type_path,
          service_handle_field: service_handle_field,
          parent_image: parent_image,
          run_as_user: run_as_user,
          deployment_type: deployment_type,
          http_protocol: ( http_protocol if deployment_type == 'web' ).to_s,
          accepts: accepts.form_data,
          memory: {
            required: memory_required,
            recommended: memory_recommended
          },
          dedicated: dedicated,
          persistent: persistent,
          immutable: immutable,
          attach_post_build: attach_post_build,
          attach_requires_restart: attach_requires_restart,
          soft_service: soft_service
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
