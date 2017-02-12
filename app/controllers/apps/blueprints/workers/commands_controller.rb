module Apps
  module Blueprints
    module Workers
      class CommandsController < BaseController

        def new
          @app.blueprint.workers.build_command
          render 'apps/blueprints/workers/update'
        end

        def destroy
          @app.blueprint.workers.delete_command(params[:id].to_i)
          render 'apps/blueprints/workers/update'
        end

      end
    end
  end
end
