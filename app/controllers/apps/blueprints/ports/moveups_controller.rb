module Apps
  module Blueprints
    module Ports
      class MoveupsController < BaseController

        def show
          @app.blueprint.ports.moveup params[:port_id]
          render
        end

      end
    end
  end
end
