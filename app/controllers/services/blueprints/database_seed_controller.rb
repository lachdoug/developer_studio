module Services
  module Blueprints
    class DatabaseSeedController < BaseController

      def update
        @service.blueprint.database_seed.update strong_params
        render
      end

      private

      def strong_params
        params.require(:service_blueprint_database_seed).permit(
          :language, :content, :script )
      end

    end
  end
end
