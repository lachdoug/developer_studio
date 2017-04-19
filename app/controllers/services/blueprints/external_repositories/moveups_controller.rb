module Services
  module Blueprints
    module ExternalRepositories
      class MoveupsController < BaseController

        def show
          @service.blueprint.external_repositories.moveup params[:external_repository_id]
          render
        end

      end
    end
  end
end
