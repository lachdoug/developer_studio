class Service
  class ServiceBlueprint
    class Scripts < ::Blueprint::Section

      attr_reader :start, :start_sudo, :install, :install_sudo, :post_install, :post_install_sudo, :shutdown, :shutdown_sudo

      def build_section
        @start = Script.new(( data || {} ).dig :start )
        @start_sudo = Script.new(( data || {} ).dig :start_sudo )
        @install = Script.new(( data || {} ).dig :install )
        @install_sudo = Script.new(( data || {} ).dig :install_sudo )
        @post_install = Script.new(( data || {} ).dig :post_install )
        @post_install_sudo = Script.new(( data || {} ).dig :post_install_sudo )
        @shutdown = Script.new(( data || {} ).dig :shutdown )
        @shutdown_sudo = Script.new(( data || {} ).dig :shutdown_sudo )
      end

      def start_attributes=(params)
        @start = Script.new params
      end

      def start_sudo_attributes=(params)
        @start_sudo = Script.new params
      end

      def install_attributes=(params)
        @install = Script.new params
      end

      def install_sudo_attributes=(params)
        @install_sudo = Script.new params
      end

      def post_install_attributes=(params)
        @post_install = Script.new params
      end

      def post_install_sudo_attributes=(params)
        @post_install_sudo = Script.new params
      end

      def shutdown_attributes=(params)
        @shutdown = Script.new params
      end

      def shutdown_sudo_attributes=(params)
        @shutdown_sudo = Script.new params
      end

      def form_data
        {
          start: start.form_data,
          start_sudo: start_sudo.form_data,
          install: install.form_data,
          install_sudo: install_sudo.form_data,
          post_install: post_install.form_data,
          post_install_sudo: post_install_sudo.form_data,
          shutdown: shutdown.form_data,
          shutdown_sudo: shutdown_sudo.form_data
        }
      end


    end
  end
end
