module Settings
  class ServiceDefinitionNamespace
    class Builder

      require 'open3'

      include ActiveModel::Model

      def initialize(url=nil)
        @url = url
      end

      attr_accessor :url
      attr_reader :error_message

      def path
        "#{Rails.application.config.persistent_data_directory}/repos/service_definitions"
      end

      def clone_remote
        stdout, stderr, status = Open3.capture3("git -C #{path} clone '#{url}'")
        if status.exitstatus == 0
          true
        else
          @error_message = stderr.split('fatal: ')[1]
          false
        end
      end

      def name
        @name ||= url.split('/').last.split('.').first
      end

    end
  end
end
