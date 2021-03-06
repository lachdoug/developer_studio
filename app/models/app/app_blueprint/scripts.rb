class App
  class AppBlueprint
    class Scripts < ::Blueprint::Section

      attr_reader :start,
                  :install,
                  :first_run,
                  :post_install,
                  :backup,
                  :restore,
                  :shutdown

      def build_section
        @start = Script.new( ( data || {} ).dig :start )
        @install = Script.new( ( data || {} ).dig :install )
        @first_run = Script.new( ( data || {} ).dig :first_run )
        @post_install = Script.new( ( data || {} ).dig :post_install )
        @backup = Script.new(( data || {} ).dig :backup )
        @restore = Script.new(( data || {} ).dig :restore )
        @shutdown = Script.new( ( data || {} ).dig :shutdown )
      end

      def start_attributes=(params)
        @start = Script.new params
      end

      def install_attributes=(params)
        @install = Script.new params
      end

      def first_run_attributes=(params)
        @first_run = Script.new params
      end

      def post_install_attributes=(params)
        @post_install = Script.new params
      end

      def backup_attributes=(params)
        @backup = Script.new params
      end

      def restore_attributes=(params)
        @restore = Script.new params
      end

      def shutdown_attributes=(params)
        @shutdown = Script.new params
      end

      def form_data
        {
          start: start.form_data,
          install: install.form_data,
          first_run: first_run.form_data,
          post_install: post_install.form_data,
          backup: backup.form_data,
          restore: restore.form_data,
          shutdown: shutdown.form_data
        }
      end

    end
  end
end
