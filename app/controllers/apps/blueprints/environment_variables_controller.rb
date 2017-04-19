module Apps
  module Blueprints
    class EnvironmentVariablesController < BaseController

      def update
        @environment_variable = @app.blueprint.environment_variables.find params[:id]
        @environment_variable.update strong_params
        # byebug
        render
      end

      def new
        @app.blueprint.environment_variables.build
        render
      end

      def destroy
        @app.blueprint.environment_variables.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_environment_variable).
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
