module Services
  module Blueprints
    class SoftLinksController < BaseController

      def update
        @soft_link = @service.blueprint.soft_links.find params[:id]
        @soft_link.update strong_params
        render
      end

      def new
        @service.blueprint.soft_links.build
        render
      end

      def destroy
        @service.blueprint.soft_links.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_soft_link).
          permit( :source, :target, :owner )
      end

    end
  end
end
