module Services
  module Blueprints
    module ApacheHtaccessFiles
      class MoveupsController < BaseController

        def show
          @service.blueprint.apache_htaccess_files.moveup params[:apache_htaccess_file_id]
          render
        end

      end
    end
  end
end
