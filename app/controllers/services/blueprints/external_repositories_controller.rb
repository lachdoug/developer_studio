module Services
  module Blueprints
    class ExternalRepositoriesController < BaseController

      def update
        @external_repository = @service.blueprint.external_repositories.find params[:id]
        @external_repository.update strong_params
        render
      end

      def new
        @service.blueprint.external_repositories.build
        render
      end

      def destroy
        @service.blueprint.external_repositories.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_external_repository).
          permit( :url, :key )
      end

    end
  end
end
