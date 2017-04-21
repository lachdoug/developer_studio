module Services
  module Blueprints
    module Configurators
      class MoveupsController < BaseController

        def show
          @service.blueprint.configurators.moveup params[:configurator_id]
          render
        end

      end
    end
  end
end
