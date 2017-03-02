module Apps
  module Blueprints
    class ActionatorsController < BaseController

      def update
        @app.blueprint.actionators.update strong_params
        render 'apps/blueprints/schedules/update'
      end

      def new
        @app.blueprint.actionators.build_actionator
        render 'apps/blueprints/actionators/update'
      end

      def destroy
        @app.blueprint.actionators.delete(params[:id].to_i)
        render 'apps/blueprints/actionators/update'
      end

      private

      def strong_params
        params.require(:app_blueprint_actionators).
          permit( actionators_attributes:
                    [ :name, :label, :description, :return_type, :return_file_name,
                      :enable_logging, script_attributes: [:language, :content],
                  variables_attributes: [
                    :name,
                    :value,
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
                        :message,
                        :required
                      ] ] ] ] )
      end

    end
  end
end
