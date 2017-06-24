module Settings
  class ServiceDefinitionNamespace
    class ServiceDefinition

      attr_reader :service_definition_publisher_namespace, :type_path

      def initialize(service_definition_publisher_namespace, type_path)
        @service_definition_publisher_namespace = service_definition_publisher_namespace
        @type_path = type_path
      end

      def content
        @content ||= repository_service_definition
      end

      def path
        "#{Rails.application.config.persistent_data_directory}/repos/service_definitions"
      end

      def repository_service_definition
        # byebug
        File.read "#{path}/#{service_definition_publisher_namespace.name}/#{file_path}"
      rescue Errno::ENOENT # no file error
        ''
      end

      def file_path
        "#{type_path}/#{type_path.split('/').last}.yaml"
      end

      def type_path_for_html_id
        type_path.gsub('/', '_-_')
      end

    end
  end
end

# module Settings
#   class ServiceDefinitionNamespace
#     class ServiceDefinition
#
#       attr_reader :service_definition_publisher_namespace, :type_path
#
#       def initialize(service_definition_publisher_namespace, type_path)
#         @service_definition_publisher_namespace = service_definition_publisher_namespace
#         @type_path = type_path
#       end
#
#       def content
#         @content ||= repository_master_branch_service_definition
#       end
#
#       def eds_content
#         @eds_content ||= repository_eds_branch_service_definition
#       end
#
#       def repository_master_branch_service_definition
#         # byebug
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} checkout -B master`
#         File.read "repos/service_definitions/#{service_definition_publisher_namespace.name}/#{file_path}"
#       rescue Errno::ENOENT # no file error
#         ''
#       end
#
#       def repository_eds_branch_service_definition
#         # byebug
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} checkout -B engines_developer_studio`
#         File.read "repos/service_definitions/#{service_definition_publisher_namespace.name}/#{file_path}"
#       rescue Errno::ENOENT # no file error
#         ''
#       end
#
#       def file_path
#         "#{type_path}/#{type_path.split('/').last}.yaml"
#       end
#
#       def type_path_for_html_id
#         type_path.gsub('/', '_-_')
#       end
#
#       def update(new_content)
#         byebug
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} checkout -B engines_developer_studio`
#         File.write "repos/service_definitions/#{service_definition_publisher_namespace.name}/#{file_path}", new_content
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} add -A`
#       end
#
#       def commit(message)
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} checkout -B engines_developer_studio`
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} commit -m '#{message}'`
#       end
#
#       def push
#         `git -C repos/service_definitions/#{service_definition_publisher_namespace.name} checkout -B engines_developer_studio`
#         stdout, stderr, status = Open3.capture3("git -C repos/service_definitions/#{service_definition_publisher_namespace.name} push -f origin engines_developer_studio")
#         if status.exitstatus == 0
#           { success: true }
#         else
#           { success: false, message: stderr }
#         end
#       end
#
#     end
#   end
# end
