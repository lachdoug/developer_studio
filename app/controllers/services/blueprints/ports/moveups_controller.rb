module Services
  module Blueprints
    module Ports
      class MoveupsController < BaseController

        def show
          @service.blueprint.ports.moveup params[:port_id]
          render
        end

      end
    end
  end
end
