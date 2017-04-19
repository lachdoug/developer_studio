class App
  class AppBlueprint
    class Base < ::Blueprint::Section

      attr_accessor :name,
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
                    :installation_report

      def build_section
        @name = data.dig :name
        @framework = data.dig :framework
        @deployment_type = data.dig :deployment_type
        @http_protocol = data.dig :http_protocol
        @framework_port_override = data.dig :framework_port_override
        @web_root_directory = data.dig :web_root_directory
        @continuous_deployment = data.dig :continuous_deployment
        @memory_required = data.dig :memory, :required
        @memory_recommended = data.dig :memory, :recommended
        @install_form_comment = data.dig :install_form_comment
        @first_run_url = data.dig :first_run_url
        @installation_report = data.dig :installation_report
      end

      def form_data
        {
          name: name,
          framework: framework,
          memory: {
            required: memory_required,
            recommended: memory_recommended
          },
          http_protocol: ( http_protocol if deployment_type == 'web' ).to_s,
          framework_port_override: framework_port_override,
          deployment_type: deployment_type,
          web_root_directory: web_root_directory,
          continuous_deployment: ActiveRecord::Type::Boolean.new.cast(continuous_deployment),
          install_form_comment: install_form_comment,
          first_run_url: first_run_url,
          installation_report: installation_report
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
