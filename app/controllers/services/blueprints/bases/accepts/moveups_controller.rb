module Services
  module Blueprints
    module Bases
      module Accepts
        class MoveupsController < BaseController

          def show
            @service.blueprint.base.accepts.moveup params[:accept_id]
            render
          end

        end
      end
    end
  end
end
