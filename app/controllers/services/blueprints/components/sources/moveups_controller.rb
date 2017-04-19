module Services
  module Blueprints
    module Components
      module Sources
        class MoveupsController < BaseController

          def show
            @service.blueprint.components.sources.moveup params[:source_id]
            render
          end

        end
      end
    end
  end
end
