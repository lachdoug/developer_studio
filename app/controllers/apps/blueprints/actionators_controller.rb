module Apps
  module Blueprints
    class ActionatorsController < BaseController

      def update
        @actionator = @app.blueprint.actionators.find params[:id]
        @actionator.update strong_params
        # byebug
        render
      end

      def new
        @app.blueprint.actionators.build
        render
      end

      def destroy
        @app.blueprint.actionators.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_actionator).
          permit( :name,
                  :label,
                  :description,
                  :return_type,
                  :return_file_name,
                  :enable_logging,
                  script_attributes: [:language, :content],
                )
      end

    end
  end
end
