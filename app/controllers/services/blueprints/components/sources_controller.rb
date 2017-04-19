module Services
  module Blueprints
    module Components
      class SourcesController < BaseController

        def update
          @source = @service.blueprint.components.sources.find params[:id]
          @source.update strong_params
          render
        end

        def new
          @service.blueprint.components.sources.build
          render
        end

        def destroy
          @service.blueprint.components.sources.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:service_blueprint_components_source).
            permit( :label, :url,
                    install_script_attributes: [:language, :content] )
        end

      end
    end
  end
end
