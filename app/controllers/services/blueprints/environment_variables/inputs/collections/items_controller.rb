module Services
  module Blueprints
    module EnvironmentVariables
      module Inputs
        module Collections
          class ItemsController < BaseController

            def new
              @environment_variable = @service.blueprint.environment_variables.
                    find( params[:environment_variable_id].to_i )
              @environment_variable.input.collection.build_item
              render
            end

            def destroy
              @environment_variable = @service.blueprint.environment_variables.
                    find params[:environment_variable_id].to_i
              @environment_variable.input.collection.delete params[:id]
              render
            end

          end
        end
      end
    end
  end
end
