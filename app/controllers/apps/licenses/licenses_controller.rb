module Apps
  module Licenses
    class LicensesController < BaseController

      def update
        @app.license.update strong_params
        render body: nil
      end

      private

      def strong_params
        params.require(:engine_license).permit(:content)
      end

    end
  end
end
