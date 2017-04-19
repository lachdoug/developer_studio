module Services
  module Blueprints
    module RakeTasks
      class MoveupsController < BaseController

        def show
          @service.blueprint.rake_tasks.moveup params[:rake_task_id]
          render
        end

      end
    end
  end
end
