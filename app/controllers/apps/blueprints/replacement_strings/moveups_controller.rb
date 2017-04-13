module Apps
  module Blueprints
    module ReplacementStrings
      class MoveupsController < BaseController

        def show
          @app.blueprint.replacement_strings.moveup params[:replacement_string_id]
          render
        end

      end
    end
  end
end
