class Service
  class ServiceDefinition
    class Commit

      include ActiveModel::Model

      def initialize(service_definition)
        @service_definition = service_definition
      end

      attr_reader :service_definition, :error_message
      attr_writer :message

      def message
        @message ||= service_definition.engine.repo.last_commit_message.strip
      end

      def do_commit(params)
        commit_result = service_definition.repo.do_commit params[:message]
        if commit_result[:success]
          true
        else
          @error_message = commit_result[:message]
          false
        end
      end

     end
  end
end
