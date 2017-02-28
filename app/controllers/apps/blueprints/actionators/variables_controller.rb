module Apps
  module Blueprints
    module Actionators
      class VariablesController < BaseController

        def new
          actionator = @app.blueprint.actionators.
                find(params[:actionator_id].to_i)
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
