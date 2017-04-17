module Apps
  class RepositoriesController < BaseController

    def show
      @app_commit = App::Commit.new(@app)
    end

  end
end
