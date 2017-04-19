module Services
  module Repositories
    class PushesController < BaseController

      def show
        # @service_push = Service::Push.new(@service)
        if @service.push.do_push
          redirect_to service_repository_path(id: @service.name), notice: "Successfully pushed #{@service.name}."
        else
          redirect_to service_repository_path(id: @service.name), alert: "Failed to push #{@service.name}. #{@service.push.error_message}"
        end
      end

    end
  end
end
