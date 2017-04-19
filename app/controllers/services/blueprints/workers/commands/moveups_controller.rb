module Services
  module Blueprints
    module Workers
      module Commands
        class MoveupsController < BaseController

          def show
            @service.blueprint.workers.commands.moveup params[:command_id]
            render
          end

        end
      end
    end
  end
end
