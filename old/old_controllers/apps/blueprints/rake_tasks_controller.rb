module Apps
  module Blueprints
    class RakeTasksController < BaseController

      def update
        @app.blueprint.rake_tasks.update strong_params
        render 'apps/blueprints/jsons/refresh'
      end

      def new
        @app.blueprint.rake_tasks.build_rake_task
        render 'apps/blueprints/rake_tasks/update'
      end

      def destroy
        @app.blueprint.rake_tasks.delete(params[:id].to_i)
        render 'apps/blueprints/rake_tasks/update'
      end


      private

      def strong_params
        params.require(:app_blueprint_rake_tasks).
          permit( rake_tasks_attributes: [ :action, :always_run ] )
      end

    end
  end
end
