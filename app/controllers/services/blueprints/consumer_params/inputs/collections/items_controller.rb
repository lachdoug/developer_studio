module Services
  module Blueprints
    module ConsumerParams
      module Inputs
        module Collections
          class ItemsController < BaseController

            def new
              @consumer_param = @service.blueprint.consumer_params.
                    find( params[:consumer_param_id].to_i )
              @consumer_param.input.collection.build_item
              render
            end

            def destroy
              @consumer_param = @service.blueprint.consumer_params.
                    find params[:consumer_param_id].to_i
              @consumer_param.input.collection.delete params[:id]
              render
            end

          end
        end
      end
    end
  end
end
