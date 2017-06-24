module Services
  module ServiceDefinitions
    class PushesController < BaseController

      def show
        # @service_push = Service::Push.new(@service)
        if @service.service_definition.push.do_push
          redirect_to service_service_definition_path(id: @service.name), notice: "Successfully pushed service definitions for #{@service.service_definition.publisher_namespace}."
        else
          redirect_to service_service_definition_path(id: @service.name), alert: "Failed to push service definitions for #{@service.service_definition.publisher_namespace}. #{@service.service_definition.push.error_message}"
        end
      end

    end
  end
end
