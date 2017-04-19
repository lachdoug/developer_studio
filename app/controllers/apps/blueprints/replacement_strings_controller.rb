module Apps
  module Blueprints
    class ReplacementStringsController < BaseController

      def update
        @replacement_string = @app.blueprint.replacement_strings.find params[:id]
        @replacement_string.update strong_params
        render
      end

      def new
        @app.blueprint.replacement_strings.build
        render
      end

      def destroy
        @app.blueprint.replacement_strings.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:app_app_blueprint_replacement_string).
          permit( :string, :source_file, :destination_file )
      end

    end
  end
end
