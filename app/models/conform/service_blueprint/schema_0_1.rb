module Conform
  class ServiceBlueprint
    class Schema_0_1

      def initialize(raw_blueprint)
        @raw_blueprint = raw_blueprint
      end

      def r(*keys)
        @raw_blueprint.dig(*keys)
      rescue
        nil
      end

      def output
        { schema: {
            type: "service_blueprint",
            version: { major: 0, minor: 1 },
            origin: "Engines Developer Studio 0.2"
          },
          metadata: metadata,
          software: software
        }
      end

      def metadata
        {
          blueprint: {
            version: {
              major: r(:metadata, :blueprint, :version, :major).to_i,
              minor: r(:metadata, :blueprint, :version, :minor).to_i,
              level: (r(:metadata, :blueprint, :version, :level) || :alpha).to_s,
              patch: r(:metadata, :blueprint, :version, :patch).to_i,
            }
          },
          software: {
            display: {
              title: r(:metadata, :software, :display, :title).to_s,
              label: r(:metadata, :software, :display, :label).to_s,
              version: r(:metadata, :software, :display, :version).to_s,
              description: r(:metadata, :software, :display, :description).to_s,
              url: r(:metadata, :software, :display, :url).to_s,
            }.delete_if { |k,v| v.blank? },
            license: {
              label: r(:metadata, :software, :license, :label).to_s,
              url: r(:metadata, :software, :license, :url).to_s,
            }.delete_if { |k,v| v.blank? }
          }.delete_if { |k,v| v.blank? },
          timestamp: timestamp
        }.delete_if { |k,v| v.blank? }
      end

      def timestamp
        DateTime.parse(r :metadata, :timestamp)
      rescue
        nil
      end

      def software
        # byebug
        {
          base: base,
          disposition: disposition,
          ports: ports,
          scripts: scripts,
          external_repositories: external_repositories,
          system_packages: system_packages,
          installed_packages: installed_packages,
          required_modules: required_modules,
          included_files: included_files,
          service_configurations: service_configurations,
          environment_variables: environment_variables,
          constants: constants,
          target_environment_variables: target_environment_variables,
          template_files: template_files,
          replacement_strings: replacement_strings,
          persistent_directories: persistent_directories,
          consumers: consumers,
          consumer_scripts: consumer_scripts,
          consumer_params: consumer_params,
          custom_files: custom_files,
          actionators: actionators,
          configurators: configurators,
          schedules: schedules,
          service_dependencies: service_dependencies,
          guises: guises,
          capabilities: capabilities,
          log_directories: log_directories,
          build_dependencies: build_dependencies,
          file_permissions: file_permissions,
          soft_links: soft_links,
          # backup_scripts: backup_scripts,
        }.delete_if { |k,v| v.blank? }
      end

      def base
        {
          name: r(:software, :base, :name).to_s,
          inherit: r(:software, :base, :inherit).to_s,
          cardinal: r(:software, :base, :cardinal).to_s,
          publisher_namespace: r(:software, :base, :publisher_namespace).to_s,
          type_path: r(:software, :base, :type_path).to_s,
          service_handle_field: r(:software, :base, :service_handle_field).to_s,
          parent_image: r(:software, :base, :parent_image).to_s,
          deployment_type: r(:software, :base, :deployment_type).to_s,
          http_protocol: r(:software, :base, :http_protocol).to_s,
          hostname: r(:software, :base, :hostname).to_s,
          domain_name: r(:software, :base, :domain_name).to_s,
          set_state: r(:software, :base, :set_state).to_s,
          default_stop_timeout: r(:software, :base, :default_stop_timeout).to_i,
          restart_policy: r(:software, :base, :restart_policy).to_s,
          restart_attempts: r(:software, :base, :restart_attempts).to_i,
          memory: memory,
          run_as_user: r(:software, :base, :run_as_user).to_s,
          user_id: r(:software, :base, :user_id).to_s,
          user_primary_group: r(:software, :base, :user_primary_group).to_s,
          create_user: r(:software, :base, :create_user).to_s,
          source_files: r(:software, :base, :source_files).to_s,
        }.delete_if { |k,v| v.blank? }
      end

      def memory
        {
          required: r(:software, :base, :memory, :required).to_i,
          recommended: r(:software, :base, :memory, :recommended).to_i
        }.delete_if { |k,v| v == 0 }
      end

      def disposition
        {
          dedicated: cast_boolean_for(r(:software, :base, :dedicated).nil? ? r(:software, :disposition, :dedicated) : r(:software, :base, :dedicated)),
          persistent: cast_boolean_for(r(:software, :base, :persistent).nil? ? r(:software, :disposition, :persistent) : r(:software, :base, :persistent)),
          immutable: cast_boolean_for(r(:software, :base, :immutable).nil? ? r(:software, :disposition, :immutable) : r(:software, :base, :immutable)),
          attach_post_build: cast_boolean_for(r(:software, :base, :attach_post_build).nil? ? r(:software, :disposition, :attach_post_build) : r(:software, :base, :attach_post_build)),
          attach_requires_restart: cast_boolean_for(r(:software, :base, :attach_requires_restart).nil? ? r(:software, :disposition, :attach_requires_restart) : r(:software, :base, :attach_requires_restart)),
          soft_service: cast_boolean_for(r(:software, :base, :soft_service).nil? ? r(:software, :disposition, :soft_service) : r(:software, :base, :soft_service)),
          shareable: cast_boolean_for(r(:software, :base, :shareable).nil? ? r(:software, :disposition, :shareable) : r(:software, :base, :shareable)),
          consumer_exportable: cast_boolean_for(r(:software, :base, :consumer_exportable).nil? ? r(:software, :disposition, :consumer_exportable) : r(:software, :base, :consumer_exportable)),
          stopped_ok: cast_boolean_for(r(:software, :base, :stopped_ok).nil? ? r(:software, :disposition, :stopped_ok) : r(:software, :base, :stopped_ok)),
          kerberos_support: cast_boolean_for(r(:software, :base, :kerberos_support).nil? ? r(:software, :disposition, :kerberos_support) : r(:software, :base, :kerberos_support)),
          host_network: cast_boolean_for(r(:software, :base, :host_network).nil? ? r(:software, :disposition, :host_network) : r(:software, :base, :host_network)),
          privileged: cast_boolean_for(r(:software, :base, :privileged).nil? ? r(:software, :disposition, :privileged) : r(:software, :base, :privileged)),
          no_ca_map: cast_boolean_for(r(:software, :base, :no_ca_map).nil? ? r(:software, :disposition, :no_ca_map) : r(:software, :base, :no_ca_map)),
          consumerless: cast_boolean_for(r(:software, :base, :consumerless).nil? ? r(:software, :disposition, :consumerless) : r(:software, :base, :consumerless)),
          start_syslog: cast_boolean_for(r(:software, :base, :start_syslog).nil? ? r(:software, :disposition, :start_syslog) : r(:software, :base, :start_syslog)),
        }.delete_if { |k,v| v.blank? }
      end

      def ports
        ( r(:software, :ports) || []).map do |p|
          port_for p
        end
      end

      def port_for(p)
        {
          port: p.dig(:port).to_s,
          external: p.dig(:external).to_s,
          protocol: p.dig(:protocol).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def scripts
        {
          start: {
            language: r(:software, :scripts, :start, :language).to_s,
            content: r(:software, :scripts, :start, :content).to_s
          }.delete_if { |k,v| v.blank? },
          start_sudo: {
            language: r(:software, :scripts, :start_sudo, :language).to_s,
            content: r(:software, :scripts, :start_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          install: {
            language: r(:software, :scripts, :install, :language).to_s,
            content: r(:software, :scripts, :install, :content).to_s
          }.delete_if { |k,v| v.blank? },
          install_sudo: {
            language: r(:software, :scripts, :install_sudo, :language).to_s,
            content: r(:software, :scripts, :install_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          post_install: {
            language: r(:software, :scripts, :post_install, :language).to_s,
            content: r(:software, :scripts, :post_install, :content).to_s
          }.delete_if { |k,v| v.blank? },
          post_install_sudo: {
            language: r(:software, :scripts, :post_install_sudo, :language).to_s,
            content: r(:software, :scripts, :post_install_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          backup: {
            language: r(:software, :scripts, :backup, :language).to_s,
            content: r(:software, :scripts, :backup, :content).to_s
          }.delete_if { |k,v| v.blank? },
          backup_sudo: {
            language: r(:software, :scripts, :backup_sudo, :language).to_s,
            content: r(:software, :scripts, :backup_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          restore: {
            language: r(:software, :scripts, :restore, :language).to_s,
            content: r(:software, :scripts, :restore, :content).to_s
          }.delete_if { |k,v| v.blank? },
          restore_sudo: {
            language: r(:software, :scripts, :restore_sudo, :language).to_s,
            content: r(:software, :scripts, :restore_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          shutdown: {
            language: r(:software, :scripts, :shutdown, :language).to_s,
            content: r(:software, :scripts, :shutdown, :content).to_s
          }.delete_if { |k,v| v.blank? },
          shutdown_sudo: {
            language: r(:software, :scripts, :shutdown_sudo, :language).to_s,
            content: r(:software, :scripts, :shutdown_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
        }.delete_if { |k,v| v.blank? }
      end

      def external_repositories
        ( r(:software, :external_repositories) || []).map do |er|
          external_repository_for er
        end
      end

      def external_repository_for(er)
        {
          source: ( er.dig(:source) || er.dig(:url) ).to_s,
          key: er.dig(:key).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def system_packages
        ( r(:software, :system_packages) || []).map do |sp|
          system_package_for sp
        end
      end

      def system_package_for(sp)
        {
          package: sp.dig(:package).to_s,
          version: sp.dig(:version).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def installed_packages
        ( r(:software, :installed_packages) || []).map do |ip|
          installed_package_for ip
        end
      end

      def installed_package_for(ip)
        {
          name: ip.dig(:name).to_s,
          download_type: ip.dig(:download_type).to_s,
          command_options: ip.dig(:command_options).to_s,
          source_url: ip.dig(:source_url).to_s,
          destination: ip.dig(:destination).to_s,
          extraction_command: ip.dig(:extraction_command).to_s,
          path_to_extracted: ip.dig(:path_to_extracted).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def required_modules
        ( r(:software, :required_modules) || []).map do |rm|
          required_module_for rm
        end
      end

      def required_module_for(rm)
        {
          name: rm.dig(:name).to_s,
          type: rm.dig(:type).to_s,
          os_package: rm.dig(:os_package).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def included_files
        ( r(:software, :included_files) || []).map do |inf|
          included_file_for inf
        end
      end

      def included_file_for(inf)
        {
          source: inf.dig(:source).to_s,
          destination: inf.dig(:destination).to_s,
          owner: inf.dig(:owner).to_s,
          group: inf.dig(:group).to_s,
          permissions: inf.dig(:permissions).to_s,
          template: cast_boolean_for(inf.dig(:template)),
        }.delete_if { |k,v| v.blank? }
      end

      def service_configurations
        ( r(:software, :service_configurations) || []).map do |sc|
          service_configuration_for sc
        end
      end

      def service_configuration_for(sc)
        {
          publisher_namespace: sc.dig(:publisher_namespace).to_s,
          type_path: sc.dig(:type_path).to_s,
          variables: sc.dig(:variables)
        }.delete_if { |k,v| v.blank? }
      end

      def environment_variables
        ( r(:software, :environment_variables) || []).map do |ev|
          environment_variable_for ev
        end
      end

      def environment_variable_for(ev)
        {
          name: ev.dig(:name).to_s,
          value: ev.dig(:value).to_s,
          mandatory: cast_boolean_for(ev.dig(:mandatory)),
          immutable: cast_boolean_for(ev.dig(:immutable)),
          ask_at_build_time: cast_boolean_for(ev.dig(:ask_at_build_time)),
          build_time_only: cast_boolean_for(ev.dig(:build_time_only)),
          input: {
            type: ev.dig(:input, :type).to_s,
            label: ev.dig(:input, :label).to_s,
            title: ev.dig(:input, :title).to_s,
            comment: ev.dig(:input, :comment).to_s,
            hint: ev.dig(:input, :hint).to_s,
            placeholder: ev.dig(:input, :placeholder).to_s,
            validation: {
              pattern: ev.dig(:input, :validation, :pattern).to_s,
              message: ev.dig(:input, :validation, :message).to_s
            }.delete_if { |k,v| v.blank? },
            collection: {
              include_blank: cast_boolean_for( ev.dig(:input, :collection, :include_blank) ),
              items: ev.dig(:input, :collection, :items) || {}
             }.delete_if { |k,v| v.blank? },
          }.delete_if { |k,v| v.blank? }
        }.delete_if { |k,v| v.blank? }
      end

      def constants
        ( r(:software, :constants) || []).map do |sc|
          constant_for sc
        end
      end

      def constant_for(sc)
        {
          name: sc.dig(:name).to_s,
          value: sc.dig(:value).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def target_environment_variables
        ( r(:software, :target_environment_variables) || []).map do |tev|
          target_environment_variable_for tev
        end
      end

      def target_environment_variable_for(tev)
        {
          variable_name: tev.dig(:variable_name).to_s,
          environment_variable_name: tev.dig(:environment_variable_name).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def template_files
        ( r(:software, :template_files) || []).map do |tf|
          template_file_for tf
        end
      end

      def template_file_for(tf)
        {
          path: tf.dig(:path).to_s,
          language: tf.dig(:language).to_s,
          content: tf.dig(:content).to_s,
          user: tf.dig(:user).to_s,
          group: tf.dig(:group).to_s,
          permissions: tf.dig(:permissions).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def consumers
        {
          accepts: Array(r(:software, :consumers, :accepts) || r(:software, :base, :accepts)),
        }.delete_if { |k,v| v.blank? }
      end

      def consumer_scripts
        {
          add: {
            language: r(:software, :consumer_scripts, :add, :language).to_s,
            content: r(:software, :consumer_scripts, :add, :content).to_s
          }.delete_if { |k,v| v.blank? },
          add_sudo: {
            language: r(:software, :consumer_scripts, :add_sudo, :language).to_s,
            content: r(:software, :consumer_scripts, :add_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          update: {
            language: r(:software, :consumer_scripts, :update, :language).to_s,
            content: r(:software, :consumer_scripts, :update, :content).to_s
          }.delete_if { |k,v| v.blank? },
          update_sudo: {
            language: r(:software, :consumer_scripts, :update_sudo, :language).to_s,
            content: r(:software, :consumer_scripts, :update_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          remove: {
            language: r(:software, :consumer_scripts, :remove, :language).to_s,
            content: r(:software, :consumer_scripts, :remove, :content).to_s
          }.delete_if { |k,v| v.blank? },
          remove_sudo: {
            language: r(:software, :consumer_scripts, :remove_sudo, :language).to_s,
            content: r(:software, :consumer_scripts, :remove_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
        }.delete_if { |k,v| v.blank? }
      end

      def consumer_params
        ( r(:software, :consumer_params) || []).map do |cp|
          consumer_param_for cp
        end
      end

      def consumer_param_for(cp)
        {
          name: cp.dig(:name).to_s,
          value: cp.dig(:value).to_s,
          mandatory: cast_boolean_for(cp.dig(:mandatory)),
          immutable: cast_boolean_for(cp.dig(:immutable)),
          ask_at_build_time: cast_boolean_for(cp.dig(:ask_at_build_time)),
          build_time_only: cast_boolean_for(cp.dig(:build_time_only)),
          input: {
            type: cp.dig(:input, :type).to_s,
            label: cp.dig(:input, :label).to_s,
            title: cp.dig(:input, :title).to_s,
            comment: cp.dig(:input, :comment).to_s,
            hint: cp.dig(:input, :hint).to_s,
            placeholder: cp.dig(:input, :placeholder).to_s,
            validation: {
              pattern: cp.dig(:input, :validation, :pattern).to_s,
              message: cp.dig(:input, :validation, :message).to_s
            }.delete_if { |k,v| v.blank? },
            collection: {
              include_blank: cast_boolean_for( cp.dig(:input, :collection, :include_blank) ),
              items: cp.dig(:input, :collection, :items) || {}
             }.delete_if { |k,v| v.blank? },
          }.delete_if { |k,v| v.blank? }
        }.delete_if { |k,v| v.blank? }
      end

      def custom_files
        ( r(:software, :custom_files) || []).map do |cf|
          custom_file_for cf
        end
      end

      def custom_file_for(cf)
        {
          type: cf.dig(:type).to_s,
          path: cf.dig(:path).to_s,
          language: cf.dig(:language).to_s,
          content: cf.dig(:content).to_s,
          execute: cast_boolean_for( cf.dig(:execute) ),
          sudo: cast_boolean_for( cf.dig(:sudo) )
        }.delete_if { |k,v| v.blank? }
      end

      def replacement_strings
        ( r(:software, :replacement_strings) || []).map do |rs|
          replacement_string_for rs
        end
      end

      def replacement_string_for(rs)
        {
          string: rs.dig(:string).to_s,
          source_file: rs.dig(:source_file).to_s,
          destination_file: rs.dig(:destination_file).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def persistent_directories
        ( r(:software, :persistent_directories) || []).map do |pd|
          persistent_directory_for pd
        end
      end

      def persistent_directory_for(pd)
        {
          path: pd.dig(:path).to_s,
          volume_name: pd.dig(:volume_name).to_s
        }.delete_if { |k,v| v.blank? }
      end

      def actionators
        ( r(:software, :actionators) || []).map do |a|
          actionator_for a
        end
      end

      def actionator_for(a)
        {
          name: a.dig(:name).to_s,
          label: a.dig(:label).to_s,
          description: a.dig(:description).to_s,
          return_type: a.dig(:return_type).to_s,
          return_file_name: a.dig(:return_file_name).to_s,
          timeout: a.dig(:timeout).present? ? a.dig(:timeout).to_i : '',
          enable_logging: cast_boolean_for( a.dig(:enable_logging) ),
          background: cast_boolean_for( a.dig(:background) ),
          variables: actionator_variables_for(a),
          script: {
            language: a.dig(:script, :language).to_s,
            content: a.dig(:script, :content).to_s
          }.delete_if { |k,v| v.blank? },
          script_sudo: {
            language: a.dig(:script_sudo, :language).to_s,
            content: a.dig(:script_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? }
        }.delete_if { |k,v| v.blank? }
      end

      def actionator_variables_for(a)
        ( a.dig(:variables) || []).map do |av|
          actionator_variable_for av
        end
      end

      def actionator_variable_for(av)
        {
          name: av.dig(:name).to_s,
          value: av.dig(:value).to_s,
          mandatory: cast_boolean_for(av.dig(:mandatory)),
          input: {
            type: av.dig(:input, :type).to_s,
            label: av.dig(:input, :label).to_s,
            title: av.dig(:input, :title).to_s,
            comment: av.dig(:input, :comment).to_s,
            hint: av.dig(:input, :hint).to_s,
            placeholder: av.dig(:input, :placeholder).to_s,
            validation: {
              pattern: av.dig(:input, :validation, :pattern).to_s,
              message: av.dig(:input, :validation, :message).to_s
            }.delete_if { |k,v| v.blank? },
            collection: {
              include_blank: cast_boolean_for( av.dig(:input, :collection, :include_blank) ),
              items: av.dig(:input, :collection, :items) || {}
             }.delete_if { |k,v| v.blank? },
          }.delete_if { |k,v| v.blank? }
        }.delete_if { |k,v| v.blank? }
      end

      def configurators
        ( r(:software, :configurators) || []).map do |c|
          configurator_for c
        end
      end

      def configurator_for(c)
        {
          name: c.dig(:name).to_s,
          label: c.dig(:label).to_s,
          description: c.dig(:description).to_s,
          enable_logging: cast_boolean_for( c.dig(:enable_logging) ),
          no_save: cast_boolean_for( c.dig(:no_save) ),
          variables: configurator_variables_for(c),
          set_script: {
            language: c.dig(:set_script, :language).to_s,
            content: c.dig(:set_script, :content).to_s
          }.delete_if { |k,v| v.blank? },
          set_script_sudo: {
            language: c.dig(:set_script_sudo, :language).to_s,
            content: c.dig(:set_script_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? },
          read_script: {
            language: c.dig(:read_script, :language).to_s,
            content: c.dig(:read_script, :content).to_s
          }.delete_if { |k,v| v.blank? },
          read_script_sudo: {
            language: c.dig(:read_script_sudo, :language).to_s,
            content: c.dig(:read_script_sudo, :content).to_s
          }.delete_if { |k,v| v.blank? }
        }.delete_if { |k,v| v.blank? }
      end

      def configurator_variables_for(c)
        ( c.dig(:variables) || []).map do |av|
          configurator_variable_for av
        end
      end

      def configurator_variable_for(cv)
        {
          name: cv.dig(:name).to_s,
          value: cv.dig(:value).to_s,
          mandatory: cast_boolean_for(cv.dig(:mandatory)),
          input: {
            type: cv.dig(:input, :type).to_s,
            label: cv.dig(:input, :label).to_s,
            title: cv.dig(:input, :title).to_s,
            comment: cv.dig(:input, :comment).to_s,
            hint: cv.dig(:input, :hint).to_s,
            placeholder: cv.dig(:input, :placeholder).to_s,
            validation: {
              pattern: cv.dig(:input, :validation, :pattern).to_s,
              message: cv.dig(:input, :validation, :message).to_s
            }.delete_if { |k,v| v.blank? },
            collection: {
              include_blank: cast_boolean_for( cv.dig(:input, :collection, :include_blank) ),
              items: cv.dig(:input, :collection, :items) || {}
             }.delete_if { |k,v| v.blank? },
          }.delete_if { |k,v| v.blank? }
        }.delete_if { |k,v| v.blank? }
      end

      def schedules
        ( r(:software, :schedules) || []).map do |s|
          schedule_for s
        end
      end

      def schedule_for(s)
        {
          label: s.dig(:label).to_s,
          timespec: {
            minute: s.dig(:timespec, :minute).to_i,
            hour: s.dig(:timespec, :hour).to_i,
            day_of_month: s.dig(:timespec, :day_of_month).to_i,
            month: s.dig(:timespec, :month).to_i,
            day_of_week: s.dig(:timespec, :day_of_week).to_i
          }.delete_if { |k,v| v.blank? },
          instruction: s.dig(:instruction).to_s,
        }.merge(
          if s.dig(:instruction).to_s == 'action'
            { actionator: schedule_actionator_for(s) }
          else
            {}
          end ).delete_if { |k,v| v.blank? }
      end

      def schedule_actionator_for(s)
        {
          name: s.dig(:actionator, :name).to_s,
          params: ( s.dig(:actionator, :params) || {} )
        }.delete_if { |k,v| v.blank? }
      end

      def service_dependencies
        ( r(:software, :service_dependencies) || []).map do |sd|
          sd.to_s
        end
      end

      def guises
        ( r(:software, :guises) || []).map do |g|
          g.to_s
        end
      end

      def capabilities
        {
          allow: r(:software, :capabilities, :allow).to_s,
          selected: ( r(:software, :capabilities, :selected) || []).map(&:to_s)
        }.delete_if { |k,v| v.blank? }
      end

      def log_directories
        ( r(:software, :log_directories) || []).map do |ld|
          ld.to_s
        end
      end

      def build_dependencies
        ( r(:software, :build_dependencies) || []).map do |ld|
          ld.to_s
        end
      end

      def file_permissions
        ( r(:software, :file_permissions) || []).map do |fp|
          {
            path: fp.dig(:path).to_s,
            recursive: cast_boolean_for( fp.dig(:recursive) ),
            user: fp.dig(:user).to_s,
            group: fp.dig(:group).to_s,
            permissions: fp.dig(:permissions).to_s,
          }
        end
      end

      def soft_links
        ( r(:software, :soft_links) || []).map do |sl|
          {
            source: sl.dig(:source).to_s,
            target: sl.dig(:target).to_s,
            owner: sl.dig(:owner).to_s,
          }
        end
      end

      # def backup_scripts
      #   {
      #     backup: {
      #       language: r(:software, :backup_scripts, :backup, :language).to_s,
      #       content: r(:software, :backup_scripts, :backup, :content).to_s
      #     }.delete_if { |k,v| v.blank? },
      #     backup_sudo: {
      #       language: r(:software, :backup_scripts, :backup_sudo, :language).to_s,
      #       content: r(:software, :backup_scripts, :backup_sudo, :content).to_s
      #     }.delete_if { |k,v| v.blank? },
      #     restore: {
      #       language: r(:software, :backup_scripts, :restore, :language).to_s,
      #       content: r(:software, :backup_scripts, :restore, :content).to_s
      #     }.delete_if { |k,v| v.blank? },
      #     restore_sudo: {
      #       language: r(:software, :backup_scripts, :restore_sudo, :language).to_s,
      #       content: r(:software, :backup_scripts, :restore_sudo, :content).to_s
      #     }.delete_if { |k,v| v.blank? },
      #   }.delete_if { |k,v| v.blank? }
      # end

      def cast_boolean_for(boolean)
        return false if boolean.nil?
        ActiveRecord::Type::Boolean.new.cast(boolean)
      end

    end
  end
end
