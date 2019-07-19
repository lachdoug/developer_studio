# class Service
#   class ServiceBlueprint
#     class BackupScripts < ::Blueprint::Section
#
#       attr_reader :backup_script, :backup_script_sudo, :restore_script, :restore_script_sudo
#
#       def build_section
#         @backup_script = Script.new(( data || {} ).dig :backup )
#         @restore_script = Script.new(( data || {} ).dig :restore )
#         @backup_script_sudo = Script.new(( data || {} ).dig :backup_sudo )
#         @restore_script_sudo = Script.new(( data || {} ).dig :restore_sudo )
#       end
#
#       def backup_script_attributes=(params)
#         @backup_script = Script.new params
#       end
#
#       def backup_script_sudo_attributes=(params)
#         @backup_script_sudo = Script.new params
#       end
#
#       def restore_script_attributes=(params)
#         @restore_script = Script.new params
#       end
#
#       def restore_script_sudo_attributes=(params)
#         @restore_script_sudo = Script.new params
#       end
#
#       def form_data
#         {
#           backup: backup_script.form_data,
#           backup_sudo: backup_script_sudo.form_data,
#           restore: restore_script.form_data,
#           restore_sudo: restore_script_sudo.form_data,
#         }
#       end
#
#     end
#   end
# end
