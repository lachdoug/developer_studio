module Services
  module Blueprints
    module LogDirectories
      class MoveupsController < BaseController

        def show
          @service.blueprint.log_directories.moveup params[:log_directory_id]
          render
        end

      end
    end
  end
end
