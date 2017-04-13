module Apps
  module Blueprints
    module CustomPhpInis
      class MoveupsController < BaseController

        def show
          @app.blueprint.custom_php_inis.moveup params[:custom_php_ini_id]
          render
        end

      end
    end
  end
end
