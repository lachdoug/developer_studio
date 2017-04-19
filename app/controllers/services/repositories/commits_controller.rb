module Services
  module Repositories
    class CommitsController < BaseController

      # def new
      #   # @service.commit = Service::Commit.new(@service)
      # end

      def create
        if params[:commit_type] == 'commit_and_push'
          create_commit_and_push
        else
          create_commit
        end
      end

      def create_commit
        # @service.commit = Service::Commit.new(@service)
        if @service.commit.do_commit(strong_params)
          redirect_to service_repository_path(id: @service.name), notice: "Successfully committed #{@service.name}."
        else
          redirect_to service_repository_path(id: @service.name), alert: "Failed to commit #{@service.name}. [#{@service.commit.error_message}]"
        end
      end

      def create_commit_and_push
        # @service.commit = Service::Commit.new(@service)
        if @service.commit.do_commit(strong_params)
          if @service.push.do_push
            redirect_to service_repository_path(id: @service.name), notice: "Successfully pushed #{@service.name}."
          else
            redirect_to service_repository_path(id: @service.name), alert: "Committed but failed to push #{@service.name}. #{@service.push.error_message}"
          end
        else
          redirect_to service_repository_path(id: @service.name), alert: "Failed to commit #{@service.name}. #{@service.commit.error_message}"
        end
      end

      private

      def strong_params
        params.require(:engine_commit).permit(:message)
      end

    end
  end
end
