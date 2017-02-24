module Apps
  module Blueprints
    module EnvironmentVariables
      module Inputs
        module Collections
          class ItemsController < BaseController

            def new
              @app.blueprint.environment_variables.
                    find(params[:environment_variable_id].to_i).input.collection.build_item
              render 'apps/blueprints/environment_variables/update'
            end

            def destroy
              @app.blueprint.environment_variables.delete_input_collection_item(params[:environment_variable_id], params[:id])
              render 'apps/blueprints/environment_variables/update'
            end

          end
        end
      end
    end
  end
end
