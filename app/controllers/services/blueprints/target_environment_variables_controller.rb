module Services
  module Blueprints
    class TargetEnvironmentVariablesController < BaseController

      def update
        @target_environment_variable = @service.blueprint.target_environment_variables.find params[:id]
        @target_environment_variable.update strong_params
        render
      end

      def new
        @service.blueprint.target_environment_variables.build
        render
      end

      def destroy
        @service.blueprint.target_environment_variables.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_target_environment_variable).permit( :variable_name, :environment_variable_name )
      end

    end
  end
end
