module Apps
  module Blueprints
    module Components
      module Sources
        class MoveupsController < BaseController

          def show
            @app.blueprint.components.sources.moveup params[:source_id]
            render
          end

        end
      end
    end
  end
end
