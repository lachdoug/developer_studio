module Services
  class ServicesController < ApplicationController

    before_action -> service_name = params[:id] { set_service service_name }, only: [:show, :edit, :update, :destroy]

    def index
      # @services = Service.all
    end

    def show
    end

    def new
      @service_builder = ServiceBuilder.new()
    end

    def create
      @service_builder = ServiceBuilder.create(strong_params)
      redirect_to services_path, notice: "Created #{@service_builder.name}."
    rescue Rugged::InvalidError => e
      redirect_to services_path, alert: "Failed to create service because #{e.message}."
    end

    private

    def strong_params
      params.require(:service_builder).permit(:name, :url)
    end

  end
end
