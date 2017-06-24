module Services
  module ServiceDefinitions
    class CommitsController < BaseController

      def create
        if params[:commit_type] == 'commit_and_push'
          create_commit_and_push
        else
          create_commit
        end
      end

      def create_commit
        # byebug
        # @service.service_definition.commit = Service::Commit.new(@service)
        if @service.service_definition.commit.do_commit(strong_params)
          redirect_to service_service_definition_path(id: @service.name), notice: "Successfully committed service definitions for #{@service.service_definition.publisher_namespace}."
        else
          redirect_to service_service_definition_path(id: @service.name), alert: "Failed to commit service definitions for #{@service.service_definition.publisher_namespace}. [#{@service.service_definition.commit.error_message}]"
        end
      end

      def create_commit_and_push
        # @service.service_definition.commit = Service::Commit.new(@service)
        if @service.service_definition.commit.do_commit(strong_params)
          if @service.service_definition.push.do_push
            redirect_to service_service_definition_path(id: @service.name), notice: "Successfully committed and pushed service definitions for #{@service.service_definition.publisher_namespace}."
          else
            redirect_to service_service_definition_path(id: @service.name), alert: "Committed but failed to push service definitions for #{@service.service_definition.publisher_namespace}. #{@service.push.error_message}"
          end
        else
          redirect_to service_service_definition_path(id: @service.name), alert: "Failed to commit #{@service.service_definition.publisher_namespace}. #{@service.service_definition.commit.error_message}"
        end
      end

      private

      def strong_params
        params.require(:service_service_definition_commit).permit(:message)
      end

    end
  end
end
