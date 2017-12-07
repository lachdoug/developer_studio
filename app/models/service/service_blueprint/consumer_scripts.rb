class Service
  class ServiceBlueprint
    class ConsumerScripts < ::Blueprint::Section

      attr_reader :add_script, :add_script_sudo, :remove_script, :remove_script_sudo, :update_script, :update_script_sudo

      def build_section
        @add_script = Script.new(( data || {} ).dig :add )
        @add_script_sudo = Script.new(( data || {} ).dig :add_sudo )
        @remove_script = Script.new(( data || {} ).dig :remove )
        @remove_script_sudo = Script.new(( data || {} ).dig :remove_sudo )
        @update_script = Script.new(( data || {} ).dig :update )
        @update_script_sudo = Script.new(( data || {} ).dig :update_sudo )
      end

      def add_script_attributes=(params)
        # byebug
        @add_script = Script.new params
      end

      def add_script_sudo_attributes=(params)
        @add_script_sudo = Script.new params
      end

      def remove_script_attributes=(params)
        @remove_script = Script.new params
      end

      def remove_script_sudo_attributes=(params)
        @remove_script_sudo = Script.new params
      end

      def update_script_attributes=(params)
        @update_script = Script.new params
      end

      def update_script_sudo_attributes=(params)
        @update_script_sudo = Script.new params
      end

      def form_data
        {
          add: add_script.form_data,
          add_sudo: add_script_sudo.form_data,
          remove: remove_script.form_data,
          remove_sudo: remove_script_sudo.form_data,
          update: update_script.form_data,
          update_sudo: update_script_sudo.form_data
        }
      end

    end
  end
end
