class App
  class Blueprint
    class Base < Section

      attr_accessor :name,
                    :framework,
                    :memory_required,
                    :memory_recommended,
                    :http_protocol,
                    :framework_port_override,
                    :deployment_type,
                    :web_root_directory,
                    :continuous_deployment,
                    :first_run_url,
                    :installation_report

      def data_location
        [ :software, :base ]
      end

      def load_data
        @name = persisted_data.dig :name
        @framework = persisted_data.dig :framework
        @memory_required = persisted_data.dig :memory, :required
        @memory_recommended = persisted_data.dig :memory, :recommended
        @http_protocol = persisted_data.dig :http_protocol
        @framework_port_override = persisted_data.dig :framework_port_override
        @deployment_type = persisted_data.dig :deployment_type
        @web_root_directory = persisted_data.dig :web_root_directory
        @continuous_deployment = persisted_data.dig :continuous_deployment
        @first_run_url = persisted_data.dig :first_run_url
        @installation_report = persisted_data.dig :installation_report
      end

      def form_data
        {
          name: name,
          framework: framework,
          memory: {
            required: memory_required,
            recommended: memory_recommended
          },
          http_protocol: http_protocol,
          framework_port_override: framework_port_override,
          deployment_type: deployment_type,
          web_root_directory: web_root_directory,
          continuous_deployment: ActiveRecord::Type::Boolean.new.cast(continuous_deployment),
          first_run_url: first_run_url,
          installation_report: installation_report
        }
      end

      def frameworks_collection
        application_config[:frameworks]
      end

      def types_collection
        [:web, :worker]
      end

      def http_protocol_collection
        [:https_and_http, :http_and_https, :https_only, :http_only]
      end

    end
  end
end
