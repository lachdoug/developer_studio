module Apps
  class AppsController < ApplicationController

    before_action -> app_name = params[:id] { set_app app_name }, only: [:show, :destroy]

    def index
      @apps = App.all
    end

    def show
      Repo::App.new(@app.name).tap &:precheck
    end

    def new
      @app_builder = App::Builder.new
    end

    def create
      @app_builder = App::Builder.new()
      if @app_builder.build(strong_params)
        redirect_to app_path(id: @app_builder.name), notice: "Successfully created #{@app_builder.name}."
      else
        redirect_to apps_path, alert: "Failed to create app. (#{@app_builder.error_message})"
      end
    end

    def destroy
      if @app.delete
        redirect_to apps_path, notice: "Deleted #{@app.name}."
      else
        redirect_to apps_path, alert: "Failed to delete #{@app.name}. (#{@app.error_message})"
      end
    end

    private

    def strong_params
      params.require(:app_builder).permit(:url)
    end

  end
end
