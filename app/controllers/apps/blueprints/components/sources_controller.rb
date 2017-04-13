module Apps
  module Blueprints
    module Components
      class SourcesController < BaseController

        def update
          @source = @app.blueprint.components.sources.find params[:id]
          @source.update strong_params
          render
        end

        def new
          @app.blueprint.components.sources.build
          render
        end

        def destroy
          @app.blueprint.components.sources.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:app_blueprint_components_source).
            permit( :label, :url,
                    install_script_attributes: [:language, :content] )
        end

      end
    end
  end
end
