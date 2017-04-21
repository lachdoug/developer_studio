module Services
  module Blueprints
    module ConsumerParams
      module Inputs
        module Collections
          module Items
            class MoveupsController < BaseController

              def show
                @consumer_param = @service.blueprint.consumer_params.find params[:consumer_param_id]
                @consumer_param.input.collection.moveup params[:item_id]
                render
              end

            end
          end
        end
      end
    end
  end
end
