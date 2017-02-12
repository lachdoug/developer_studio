module Apps
  class RepositoriesController < BaseController

    def show
      if @app.repository.uncommitted_diffs.present?
        @app_commit = App::Commit.new(@app)
      # else
      #   @app_push = App::Push.new(@app)
      end
    end

  end
end
