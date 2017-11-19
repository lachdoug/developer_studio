module Services
  module Blueprints
    module Configurators
      class VariablesController < BaseController

        def update
          @configurator = @service.blueprint.configurators.find params[:configurator_id]
          @variable = @configurator.variables.find params[:id]
          @variable.update strong_params
          render
        end

        def new
          @configurator = @service.blueprint.configurators.find params[:configurator_id]
          @configurator.variables.build
          render
        end

        def destroy
          @configurator = @service.blueprint.configurators.find params[:configurator_id]
          @configurator.variables.delete params[:id]
          render
        end

        private

        def strong_params
          params.require(:service_service_blueprint_configurator_variable).
            permit( :name,
                    :value,
                    :mandatory,
                    input_attributes: [
                      :type,
                      :label,
                      :title,
                      :comment,
                      :hint,
                      :placeholder,
                      collection_attributes: [
                        :include_blank,
                        items_attributes: [
                          :value,
                          :label
                        ]
                      ],
                      validation_attributes: [
                        :pattern,
                        :message
                      ] ]
                  )
        end

      end
    end
  end
end
