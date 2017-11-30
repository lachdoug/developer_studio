class Service
  class ServiceBlueprint
    class ConsumerScripts < ::Blueprint::Section

      attr_reader :add_script, :remove_script, :update_script

      def build_section
        @add_script = Script.new(( data || {} ).dig :add )
        @remove_script = Script.new(( data || {} ).dig :remove )
        @update_script = Script.new(( data || {} ).dig :update )
      end

      def add_script_attributes=(params)
        # byebug
        @add_script = Script.new params
      end

      def remove_script_attributes=(params)
        @remove_script = Script.new params
      end

      def update_script_attributes=(params)
        @update_script = Script.new params
      end

      def form_data
        # byebug
        {
          add: add_script.form_data,
          remove: remove_script.form_data,
          update: update_script.form_data
        }
      end

    end
  end
end
