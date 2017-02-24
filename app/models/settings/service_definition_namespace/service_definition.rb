module Settings
  class ServiceDefinitionNamespace
    class ServiceDefinition

      attr_reader :service_definition_namespace, :type_path

      def initialize(service_definition_namespace, type_path)
        @service_definition_namespace = service_definition_namespace
        @type_path = type_path
      end

      def content
        @content ||= repository_service_definition
      end

      def repository_service_definition
        # byebug
        File.read "repos/service_definitions/#{service_definition_namespace.name}/#{file_path}"
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
