module Services
  module Blueprints
    module Workers
      class CommandsController < BaseController

        def update
          @command = @service.blueprint.workers.commands.find params[:id]
          @command.update strong_params
          render
        end

        def new
          @service.blueprint.workers.commands.build
          # byebug
          render
        end

        def destroy
          @service.blueprint.workers.commands.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:service_service_blueprint_workers_command).
            permit( :name, :command )
        end

      end
    end
  end
end
