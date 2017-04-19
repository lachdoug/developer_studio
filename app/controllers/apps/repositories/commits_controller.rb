module Apps
  module Repositories
    class CommitsController < BaseController

      # def new
      #   # @app.commit = App::Commit.new(@app)
      # end

      def create
        if params[:commit_type] == 'commit_and_push'
          create_commit_and_push
        else
          create_commit
        end
      end

      def create_commit
        # @app.commit = App::Commit.new(@app)
        if @app.commit.do_commit(strong_params)
          redirect_to app_repository_path(id: @app.name), notice: "Successfully committed #{@app.name}."
        else
          redirect_to app_repository_path(id: @app.name), alert: "Failed to commit #{@app.name}. [#{@app.commit.error_message}]"
        end
      end

      def create_commit_and_push
        # @app.commit = App::Commit.new(@app)
        if @app.commit.do_commit(strong_params)
          if @app.push.do_push
            redirect_to app_repository_path(id: @app.name), notice: "Successfully pushed #{@app.name}."
          else
            redirect_to app_repository_path(id: @app.name), alert: "Committed but failed to push #{@app.name}. #{@app.push.error_message}"
          end
        else
          redirect_to app_repository_path(id: @app.name), alert: "Failed to commit #{@app.name}. #{@app.commit.error_message}"
        end
      end

      private

      def strong_params
        params.require(:engine_commit).permit(:message)
      end

    end
  end
end
