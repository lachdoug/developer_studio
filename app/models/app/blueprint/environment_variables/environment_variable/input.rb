class App
  class Blueprint
    class EnvironmentVariables
      class EnvironmentVariable
        class Input

          include ActiveModel::Model

          attr_accessor :label,
                        :type,
                        :title,
                        :collection,
                        :comment,
                        :hint,
                        :placeholder
          attr_reader :validation, :collection

          def validation_attributes=(params={})
            @validation = Validation.new params
          end

          def collection_attributes=(params={})
            @collection = Collection.new params
          end

          def build_validation
            @validation = Validation.new
          end

          def build_collection
            @collection = Collection.new
          end

          def type_collection
            [ :string,
              :boolean,
              :email,
              :url,
              :tel,
              :password,
              :password_with_confirmation,
              :uuid,
              :text,
              :file,
              :hidden,
              :integer,
              :float,
              :decimal,
              :range,
              :datetime,
              :date,
              :time,
              :select,
              :radio_buttons,
              :check_boxes,
              :country,
              :time_zone ]
          end

          def form_data
            {
              label: label,
              type: type,
              title: title,
              comment: comment,
              hint: hint,
              placeholder: placeholder,
              collection: collection.form_data,
              validation: validation.form_data
            }
          end

        end
      end
    end
  end
end
