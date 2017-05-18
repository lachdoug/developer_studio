class App
  class AppBlueprint
    class Scripts < ::Blueprint::Section

      attr_reader :start, :install, :post_install, :shutdown

      def build_section
        @start = Script.new( ( data || {} ).dig :start )
        @install = Script.new( ( data || {} ).dig :install )
        @post_install = Script.new( ( data || {} ).dig :post_install )
        @shutdown = Script.new( ( data || {} ).dig :shutdown )
      end

      def start_attributes=(params)
        @start = Script.new params
      end

      def install_attributes=(params)
        @install = Script.new params
      end

      def post_install_attributes=(params)
        @post_install = Script.new params
      end

      def shutdown_attributes=(params)
        @shutdown = Script.new params
      end

      def form_data
        {
          start: start.form_data,
          install: install.form_data,
          post_install: post_install.form_data,
          shutdown: shutdown.form_data
        }
      end


    end
  end
end
