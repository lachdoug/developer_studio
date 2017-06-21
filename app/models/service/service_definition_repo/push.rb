class Service
  class ServiceDefinitionRepo
    class Push

      include ActiveModel::Model

      def initialize(service_definition_repo)
        @service_definition_repo = service_definition_repo
      end

      attr_reader :service_definition_repo, :error_message

      def do_push
        push_result = service_definition_repo.do_push
        if push_result[:success]
          true
        else
          @error_message = push_result[:message].gsub('hint: ', '')
          false
        end
      end

     end
  end
end
