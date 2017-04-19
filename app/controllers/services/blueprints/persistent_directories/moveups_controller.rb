module Services
  module Blueprints
    module PersistentDirectories
      class MoveupsController < BaseController

        def show
          @service.blueprint.persistent_directories.moveup params[:persistent_directory_id]
          render
        end

      end
    end
  end
end
