module Services
  module Blueprints
    module CustomFiles
      class MoveupsController < BaseController

        def show
          @service.blueprint.custom_files.moveup params[:custom_file_id]
          render
        end

      end
    end
  end
end
