module Services
  class BaseController < ApplicationController

    before_action :set_service

    def set_service
      super params[:service_id]
    end

  end
end
