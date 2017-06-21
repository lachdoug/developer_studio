class Service
  class ServiceDefinitionRepo
    class Commit

      include ActiveModel::Model

      def initialize(service_definition_repo)
        @service_definition_repo = service_definition_repo
      end

      attr_reader :service_definition_repo, :error_message
      attr_writer :message

      def message
        @message ||= service_definition_repo.engine.repo.last_commit_message
      end

      def do_commit(params)
        # byebug
        commit_result = service_definition_repo.do_commit params[:message]
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
