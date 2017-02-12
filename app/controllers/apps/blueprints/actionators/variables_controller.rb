module Apps
  module Blueprints
    module Actionators
      class VariablesController < BaseController

        def new
          # The actionators section form allows user to create a
          # new variable on an unsaved actionator.
          # In this case, build a new actionator
          # before building the variable.
          actionator = @app.blueprint.actionators.
                find(params[:actionator_id].to_i)
          actionator = @app.blueprint.actionators.
                build_actionator unless actionator
          actionator.build_variable
          render 'apps/blueprints/actionators/update'
        end

        def destroy
          @app.blueprint.actionators.delete_variable_input_collection_item(params[:actionator_id], params[:variable_id], params[:id])
          render 'apps/blueprints/actionators/update'
        end

      end
    end
  end
end
