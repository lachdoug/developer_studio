module Apps
  module Blueprints
    module Actionators
      module Variables
        module Inputs
          module Collections
            class ItemsController < BaseController

              # def update
              #   @actionator = @app.blueprint.actionators.find params[:actionator_id]
              #   @variable = @actionator.variables.find params[:actionator_id]
              #   @variable.update strong_params
              #   render
              # end

              def new
                @actionator = @app.blueprint.actionators.find params[:actionator_id]
                @variable = @actionator.variables.find params[:variable_id]
                @variable.input.collection.build
                render
              end

              def destroy
                @actionator = @app.blueprint.actionators.find params[:actionator_id]
                @variable = @actionator.variables.find params[:variable_id]
                @variable.input.collection.delete params[:id]
                render
              end

              private

              # def strong_params
              #   params.require(:app_blueprint_actionator_variable).
              #     permit( :name,
              #             :value,
              #             :mandatory,
              #             input_attributes: [
              #               :type,
              #               :label,
              #               :title,
              #               :comment,
              #               :hint,
              #               :placeholder,
              #               collection_attributes: [
              #                 :include_blank,
              #                 items_attributes: [
              #                   :value,
              #                   :label
              #                 ]
              #               ],
              #               validation_attributes: [
              #                 :pattern,
              #                 :message
              #               ] ]
              #           )
              # end

            end
          end
        end
      end
    end
  end
end
