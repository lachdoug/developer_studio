module Apps
  module Blueprints
    module RequiredModules
      class MoveupsController < BaseController

        def show
          @app.blueprint.required_modules.moveup params[:required_module_id]
          render
        end

      end
    end
  end
end
