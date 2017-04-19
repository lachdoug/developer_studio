module Services
  module Blueprints
    class EnvironmentVariablesController < BaseController

      def update
        @environment_variable = @service.blueprint.environment_variables.find params[:id]
        @environment_variable.update strong_params
        # byebug
        render
      end

      def new
        @service.blueprint.environment_variables.build
        render
      end

      def destroy
        @service.blueprint.environment_variables.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_environment_variable).
          permit( :name,
                  :value,
                  :mandatory,
                  :immutable,
                  :ask_at_build_time,
                  :build_time_only,
                  input_attributes: [
                    :type,
                    :label,
                    :title,
                    :comment,
                    :hint,
                    :placeholder,
                    collection_attributes: [
                      :include_blank,
                      items_attributes: [
                        :value,
                        :label
                      ]
                    ],
                    validation_attributes: [
                      :pattern,
                      :message
                    ]
                  ]
                )
      end

    end
  end
end
