module Apps
  module Repositories
    class CommitsController < BaseController

      def new
        @app_commit = App::Commit.new(@app)
      end

      def create
        if params[:commit_type] == 'commit_and_push'
          create_commit_and_push
        else
          create_commit
        end
      end

      def create_commit
        @app_commit = App::Commit.new(@app)
        if @app_commit.commit(strong_params)
          redirect_to app_repository_path(id: @app.name), notice: "Successfully committed #{@app.name}."
        else
          redirect_to app_repository_path(id: @app.name), alert: "Failed to commit #{@app.name}. [#{@app_commit.error_message}]"
        end
      end

      def create_commit_and_push
        @app_commit = App::Commit.new(@app)
        if @app_commit.commit(strong_params)
          @app_push = App::Push.new(@app)
          if @app_push.push
            redirect_to app_repository_path(id: @app_push.name), notice: "Successfully pushed #{@app_push.name}."
          else
            redirect_to app_repository_path(id: @app.name), alert: "Committed but failed to push #{@app.name}. [#{@app_commit.error_message}]"
          end
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
