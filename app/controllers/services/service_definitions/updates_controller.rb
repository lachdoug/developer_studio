module Services
  module ServiceDefinitions
    class UpdatesController < BaseController

      def show
        # @service_push = Service::Push.new(@service)
        if @service.service_definition.repo.update
          redirect_to service_service_definition_path(id: @service.name), notice: "Successfully updated #{@service.service_definition.publisher_namespace}/#{@service.service_definition.type_path}.yaml."
        else
          redirect_to service_service_definition_path(id: @service.name), alert: "Failed to updated #{@service.service_definition.publisher_namespace}/#{@service.service_definition.type_path}.yaml."
        end
      end

    end
  end
end
