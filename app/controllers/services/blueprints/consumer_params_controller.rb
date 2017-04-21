module Services
  module Blueprints
    class ConsumerParamsController < BaseController

      def update
        @consumer_param = @service.blueprint.consumer_params.find params[:id]
        @consumer_param.update strong_params
        # byebug
        render
      end

      def new
        @service.blueprint.consumer_params.build
        render
      end

      def destroy
        @service.blueprint.consumer_params.delete params[:id]
        render
      end

      private

      def strong_params
        params.require(:service_service_blueprint_consumer_param).
          permit( :name,
                  :value,
                  :mandatory,
                  :immutable,
                  :ask_at_build_time,
                  :build_time_only,
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
                    ]
                  ]
                )
      end

    end
  end
end
