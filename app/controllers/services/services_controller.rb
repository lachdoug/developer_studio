module Services
  class ServicesController < ApplicationController

    before_action -> service_name = params[:id] { set_service service_name }, only: [:show, :destroy]

    def index
      @services = Service.all
    end

    def show
      @service.repo.precheck
      # Repo::Service.new(@service.name).tap &:precheck
    end

    def new
      @service_builder = Service::ServiceBuilder.new
    end

    def create
      @service_builder = Service::ServiceBuilder.new()
      if @service_builder.build(strong_params)
        redirect_to service_path(id: @service_builder.name), notice: "Successfully created #{@service_builder.name}."
      else
        redirect_to services_path, alert: "Failed to create service. (#{@service_builder.error_message})"
      end
    end

    def destroy
      if @service.repo.delete
        redirect_to services_path, notice: "Deleted #{@service.name}."
      else
        redirect_to services_path, alert: "Failed to delete #{@service.name}."
      end
    end

    private

    def strong_params
      params.require(:service_service_builder).permit(:url)
    end

  end
end
