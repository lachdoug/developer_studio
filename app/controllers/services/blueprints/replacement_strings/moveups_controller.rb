module Services
  module Blueprints
    module ReplacementStrings
      class MoveupsController < BaseController

        def show
          @service.blueprint.replacement_strings.moveup params[:replacement_string_id]
          render
        end

      end
    end
  end
end
