module Settings
  class DropdownsConfigsController < ApplicationController

    before_action :set_dropdowns_config

    def show
    end

    def update
      @dropdowns_config.update(strong_params)
    end

    private

    def strong_params
      params.require(:settings_dropdowns_config).permit(:config_yaml)
    end

    def set_dropdowns_config
      @dropdowns_config = Settings::DropdownsConfig.load
    end

  end
end
