module Apps
  module Blueprints
    module Actionators
      module Variables
        class InputCollectionItemsController < BaseController

          def new
            @app.blueprint.actionators.
                  find_actionator_variable(params[:actionator_id], params[:variable_id]).
                  input.collection.build_item
            render 'apps/blueprints/actionators/update'
          end

          def destroy
            @app.blueprint.actionators.
            delete_variable_input_collection_item(params[:actionator_id], params[:variable_id], params[:id])
            render 'apps/blueprints/actionators/update'
          end

        end
      end
    end
  end
end
