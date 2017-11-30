module Services
  module Blueprints
    module ServiceDependencies
      class MoveupsController < BaseController

        def show
          @service.blueprint.service_dependencies.moveup params[:service_dependency_id]
          render
        end

      end
    end
  end
end
