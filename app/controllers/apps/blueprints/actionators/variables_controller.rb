module Apps
  module Blueprints
    module Actionators
      class VariablesController < BaseController

        def update
          @actionator = @app.blueprint.actionators.find params[:actionator_id]
          # get associated schedules to refresh
          @actionator_schedules = associated_schedules
          @variable = @actionator.variables.find params[:id]
          @variable.update strong_params
          render
        end

        def new
          @actionator = @app.blueprint.actionators.find params[:actionator_id]
          @actionator.variables.build
          render
        end

        def destroy
          @actionator = @app.blueprint.actionators.find params[:actionator_id]
          @actionator_schedules = associated_schedules
          @actionator.variables.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:app_app_blueprint_actionator_variable).
            permit( :name,
                    :value,
                    :mandatory,
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
                      ] ]
                  )
        end

        def associated_schedules
          @app.blueprint.schedules.select{ |schedule| schedule.actionator_name == @actionator.name }
        end

      end
    end
  end
end
