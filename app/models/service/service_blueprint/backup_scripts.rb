class Service
  class ServiceBlueprint
    class BackupScripts < ::Blueprint::Section

      attr_reader :backup_script, :restore_script

      def build_section
        @backup_script = Script.new(( data || {} ).dig :backup )
        @restore_script = Script.new(( data || {} ).dig :restore )
      end

      def backup_script_attributes=(params)
        @backup_script = Script.new params
      end

      def restore_script_attributes=(params)
        @restore_script = Script.new params
      end

      def form_data
        {
          backup: backup_script.form_data,
          restore: restore_script.form_data,
        }
      end

    end
  end
end
