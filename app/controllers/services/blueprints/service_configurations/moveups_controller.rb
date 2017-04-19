module Services
  module Blueprints
    module ServiceConfigurations
      class MoveupsController < BaseController

        def show
          @service.blueprint.service_configurations.moveup params[:service_configuration_id]
          render
        end

      end
    end
  end
end
