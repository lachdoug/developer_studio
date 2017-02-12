module Apps
  module Repositories
    class CommitsController < BaseController

      def new
        @app_commit = App::Commit.new(@app)
      end

      def create
        @app_commit = App::Commit.new(@app)
        if @app_commit.commit(strong_params)
          redirect_to app_repository_path(id: @app.name), notice: "Successfully committed #{@app.name}."
        else
          redirect_to app_repository_path(id: @app.name), alert: "Failed to commit #{@app.name}. [#{@app_commit.error_message}]"
        end
      end

      private

      def strong_params
        params.require(:app_commit).permit(:message)
      end

    end
  end
end
