module Apps
  module Readmes
    class ReadmesController < BaseController

      def update
        @app.readme.update strong_params
        render body: nil
      end

      private

      def strong_params
        params.require(:engine_readme).permit(:content)
      end

    end
  end
end
