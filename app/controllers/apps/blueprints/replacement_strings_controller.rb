module Apps
  module Blueprints
    class ReplacementStringsController < BaseController

      def update
        @app.blueprint.replacement_strings.update strong_params
        render 'apps/blueprints/jsons/update'
      end

      def new
        @app.blueprint.replacement_strings.build_replacement_string
        render 'apps/blueprints/replacement_strings/update'
      end

      def destroy
        @app.blueprint.replacement_strings.delete(params[:id].to_i)
        render 'apps/blueprints/replacement_strings/update'
      end


      private

      def strong_params
        params.require(:app_blueprint_replacement_strings).
          permit( replacement_strings_attributes: [ :string, :source_file, :destination_file ] )
      end

    end
  end
end
