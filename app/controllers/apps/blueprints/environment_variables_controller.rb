module Apps
  module Blueprints
    class EnvironmentVariablesController < BaseController

      def update
        @app.blueprint.environment_variables.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.environment_variables.build
        render 'apps/blueprints/environment_variables/update'
      end

      def destroy
        @app.blueprint.environment_variables.delete(params[:id].to_i)
        render 'apps/blueprints/environment_variables/update'
      end

      private

# app_blueprint_variables"=>{"variables_attributes"

      def strong_params
        params.require(:app_blueprint_environment_variables).permit(environment_variables_attributes: [
          :name,
          :value,
          :ask_at_build_time,
          :build_time_only,
          :immutable,
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
              :message,
              :required
            ]
          ]
        ] )
      end



    end
  end
end
