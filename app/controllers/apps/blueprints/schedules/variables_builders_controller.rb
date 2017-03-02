module Apps
  module Blueprints
    module Schedules
      class VariablesBuildersController < BaseController

        def new
          if @app.blueprint.schedules.find(params[:id]).load_variables_from_blueprint_actionator
            render 'apps/blueprints/schedules/update'
          else
            render 'update_fail'
          end
        end

      end
    end
  end
end
