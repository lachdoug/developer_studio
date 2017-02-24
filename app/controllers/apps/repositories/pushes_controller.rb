module Apps
  module Repositories
    class PushesController < BaseController

      def show
        @app_push = App::Push.new(@app)
        if @app_push.push
          redirect_to app_repository_path(id: @app_push.name), notice: "Successfully pushed #{@app_push.name}."
        else
          redirect_to app_repository_path(id: @app_push.name), alert: "Failed to push #{@app_push.name}. (#{@app_push.error_message})"
        end
      end

    end
  end
end
