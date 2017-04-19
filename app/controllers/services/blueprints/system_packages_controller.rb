module Services
  module Blueprints
    class SystemPackagesController < BaseController

      def update
        @system_package = @service.blueprint.system_packages.find params[:id]
        @system_package.update strong_params
        render
      end

      def new
        @service.blueprint.system_packages.build
        render
      end

      def destroy
        @service.blueprint.system_packages.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_system_package).
          permit( :package, :version )
      end

    end
  end
end
