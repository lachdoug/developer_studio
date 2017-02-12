module Apps
  module Blueprints
    module Components
      class SourcesController < BaseController

        def new
          @app.blueprint.components.build_source
          render 'apps/blueprints/components/update'
        end

        def destroy
          @app.blueprint.components.delete_source(params[:id].to_i)
          render 'apps/blueprints/components/update'
        end

      end
    end
  end
end
