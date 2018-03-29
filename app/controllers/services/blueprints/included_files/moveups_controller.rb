module Services
  module Blueprints
    module IncludedFiles
      class MoveupsController < BaseController

        def show
          @service.blueprint.included_files.moveup params[:included_file_id]
          render
        end

      end
    end
  end
end
