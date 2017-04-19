module Apps
  module Repositories
    class PushesController < BaseController

      def show
        # @app_push = App::Push.new(@app)
        if @app.push.do_push
          redirect_to app_repository_path(id: @app.name), notice: "Successfully pushed #{@app.name}."
        else
          redirect_to app_repository_path(id: @app.name), alert: "Failed to push #{@app.name}. #{@app.push.error_message}"
        end
      end

    end
  end
end
