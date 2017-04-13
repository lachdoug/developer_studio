module Apps
  module Blueprints
    class EnvironmentVariablesController < BaseController

      def update
        # new_blueprint_environment_variable = @app.blueprint.environment_variables.environment_variables.last.new_record?
        @app.blueprint.environment_variables.update(strong_params)
        # if new_blueprint_environment_variable
          # render 'apps/blueprints/environment_variables/new'
        # else
          render 'apps/blueprints/jsons/refresh'
        # end
      end

      def new
        @app.blueprint.environment_variables.build
        render 'apps/blueprints/environment_variables/new'
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
        ] )
      end



    end
  end
end
