class Service
  class ServiceDefinition
    class Push

      include ActiveModel::Model

      def initialize(service_definition)
        @service_definition = service_definition
      end

      attr_reader :service_definition, :error_message

      def do_push
        push_result = service_definition.repo.do_push
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
