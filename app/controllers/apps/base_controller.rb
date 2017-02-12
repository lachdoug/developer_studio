module Apps
  class BaseController < ApplicationController

    before_action :set_app

    def set_app
      super params[:app_id]
    end

  end
end
