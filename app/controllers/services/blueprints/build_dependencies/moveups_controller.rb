module Services
  module Blueprints
    module BuildDependencies
      class MoveupsController < BaseController

        def show
          @service.blueprint.build_dependencies.moveup params[:build_dependency_id]
          render
        end

      end
    end
  end
end
