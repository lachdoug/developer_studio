module Services
  module Blueprints
    class RakeTasksController < BaseController

      def update
        @rake_task = @service.blueprint.rake_tasks.find params[:id]
        @rake_task.update strong_params
        render
      end

      def new
        @service.blueprint.rake_tasks.build
        render
      end

      def destroy
        @service.blueprint.rake_tasks.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_rake_task).
          permit( :action, :always_run )
      end

    end
  end
end
