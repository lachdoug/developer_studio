module Services
  module Repositories
    class ServiceDefinitionPushesController < BaseController

      def show
        # @service_push = Service::Push.new(@service)
        if @service.service_definition_repo.push.do_push
          redirect_to service_repository_path(id: @service.name), notice: "Successfully pushed #{@service.service_definition_repo.publisher_namespace}."
        else
          redirect_to service_repository_path(id: @service.name), alert: "Failed to push #{@service.service_definition_repo.publisher_namespace}. #{@service.service_definition_repo.push.error_message}"
        end
      end

    end
  end
end
