module Apps
  module Blueprints
    module ApacheHtaccessFiles
      class MoveupsController < BaseController

        def show
          @app.blueprint.apache_htaccess_files.moveup params[:apache_htaccess_file_id]
          render
        end

      end
    end
  end
end
