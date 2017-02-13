class DropdownsConfigsController < ApplicationController

  before_action :set_dropdowns_config

  # def index
  #   @apps = App.all
  # end

  def show
    # @app.blueprint.load_all
  end

  def update
    @dropdowns_config.update(strong_params)
  end

  # def new
  #   @app_builder = App::Builder.new
  # end
  #
  # def create
  #   @app_builder = App::Builder.create(strong_params)
  #   redirect_to apps_path, notice: "Created #{@app_builder.name}."
  # rescue Rugged::NetworkError, Rugged::InvalidError => e
  #   redirect_to apps_path, alert: "Failed to create app. [#{e.message}]"
  # end
  #
  private
  #
  def strong_params
    params.require(:dropdowns_config).permit(:config_yaml)
  end

  def set_dropdowns_config
    @dropdowns_config = DropdownsConfig.load
  end

end
