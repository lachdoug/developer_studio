module Apps
  module Blueprints
    module TemplateFiles
      class MoveupsController < BaseController

        def show
          @app.blueprint.template_files.moveup params[:template_file_id]
          render
        end

      end
    end
  end
end
