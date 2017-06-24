module Services
  module ServiceDefinitions
    class ClonesController < BaseController

      def show
        # @service_push = Service::Push.new(@service)
        if @service.service_definition.repo.clone_remote
          redirect_to service_service_definition_path(id: @service.name), notice: "Successfully created working repository for #{@service.service_definition.publisher_namespace}."
        else
          redirect_to service_service_definition_path(id: @service.name), alert: "Failed to create working repository for #{@service.service_definition.publisher_namespace}. #{@service.service_definition.repo.error_message}"
        end
      end

    end
  end
end
