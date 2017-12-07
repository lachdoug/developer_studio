module Services
  module Blueprints
    module LibraryScripts
      class MoveupsController < BaseController

        def show
          @service.blueprint.library_scripts.moveup params[:library_script_id]
          render
        end

      end
    end
  end
end
