module Apps
  module Blueprints
    module Workers
      class CommandsController < BaseController

        def update
          @command = @app.blueprint.workers.commands.find params[:id]
          @command.update strong_params
          render
        end

        def new
          @app.blueprint.workers.commands.build
          # byebug
          render
        end

        def destroy
          @app.blueprint.workers.commands.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:app_app_blueprint_workers_command).
            permit( :name, :command )
        end

      end
    end
  end
end
