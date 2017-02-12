module Apps
  module Blueprints
    module EnvironmentVariables
      module Inputs
        module Collections
          class ItemsController < BaseController

            def new
              # # The environment variables section form allows user to create a
              # # new collection item on an unsaved environment variable.
              # # In this case, build a new environment variable
              # # before building the collection item.
              # environment_variable =

              @app.blueprint.environment_variables.
                    find(params[:environment_variable_id].to_i).input.collection.build_item
              # environment_variable = @app.blueprint.environment_variables.
              #       build_environment_variable unless environment_variable
              # environment_variable.input.collection.build_item
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
