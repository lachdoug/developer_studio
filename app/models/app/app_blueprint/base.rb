class App
  class AppBlueprint
    class Base < ::Blueprint::Section

      attr_accessor :name,
                    :inherit,
                    :framework,
                    :parent_image,
                    :run_as_user,
                    :memory_required,
                    :memory_recommended,
                    :http_protocol,
                    :framework_port_override,
                    :deployment_type,
                    :username,
                    :user_primary_group,
                    :sudo_list,
                    :web_root_directory,
                    :continuous_deployment,
                    :install_form_comment,
                    :first_run_url,
                    :installation_report

      def build_section
        @name = ( data || {} ).dig :name
        @inherit = ( data || {} ).dig :inherit
        @framework = ( data || {} ).dig :framework
        @parent_image = ( data || {} ).dig :parent_image
        @run_as_user = ( data || {} ).dig :run_as_user
        @deployment_type = ( data || {} ).dig :deployment_type
        @http_protocol = ( data || {} ).dig :http_protocol
        @framework_port_override = ( data || {} ).dig :framework_port_override
        @web_root_directory = ( data || {} ).dig :web_root_directory
        @username = ( data || {} ).dig :username
        @user_primary_group = ( data || {} ).dig :user_primary_group
        @sudo_list = ( data || {} ).dig :sudo_list
        @continuous_deployment = ( data || {} ).dig :continuous_deployment
        @memory_required = ( data || {} ).dig :memory, :required
        @memory_recommended = ( data || {} ).dig :memory, :recommended
        @install_form_comment = ( data || {} ).dig :install_form_comment
        @first_run_url = ( data || {} ).dig :first_run_url
        @installation_report = ( data || {} ).dig :installation_report
      end

      def form_data
        {
          name: name,
          inherit: inherit,
          framework: framework,
          deployment_type: deployment_type,
          parent_image: parent_image,
          run_as_user: run_as_user,
          http_protocol: ( http_protocol if deployment_type == 'web' ).to_s,
          framework_port_override: framework_port_override,
          web_root_directory: web_root_directory,
          username: username,
          user_primary_group: user_primary_group,
          sudo_list: sudo_list,
          continuous_deployment: cast_as_boolean(continuous_deployment),
          memory: {
            required: memory_required.to_i,
            recommended: memory_recommended.to_i
          },
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
