module Services
  class ServicesController < ApplicationController

    before_action -> service_name = params[:id] { set_service service_name }, only: [:show, :edit, :update, :destroy]

    def index
      render html: 'Please come back later...', layout: true
    end

  end
end
