class SettingsController < ApplicationController

  def show

  end

  # def update
  #   @application_config.update(strong_params)
  # end
  #
  # # def new
  # #   @app_builder = App::Builder.new
  # # end
  # #
  # # def create
  # #   @app_builder = App::Builder.create(strong_params)
  # #   redirect_to apps_path, notice: "Created #{@app_builder.name}."
  # # rescue Rugged::NetworkError, Rugged::InvalidError => e
  # #   redirect_to apps_path, alert: "Failed to create app. [#{e.message}]"
  # # end
  # #
  # private
  # #
  # def strong_params
  #   params.require(:application_config).permit(:config_yaml)
  # end
  #
  # def set_application_config
  #   @application_config = ApplicationConfig.load
  # end

end
