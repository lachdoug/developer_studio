module Services
  module Blueprints
    class RequiredModulesController < BaseController

      def update
        @required_module = @service.blueprint.required_modules.find params[:id]
        @required_module.update strong_params
        render
      end

      def new
        @service.blueprint.required_modules.build
        render
      end

      def destroy
        @service.blueprint.required_modules.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_required_module).
          permit( :type, :os_package, :name )
      end

    end
  end
end
