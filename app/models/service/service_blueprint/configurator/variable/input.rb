class Service
  class ServiceBlueprint
    class Configurator
      class Variable
        class Input

          include ActiveModel::Model

          attr_accessor :label,
                        :type,
                        :title,
                        :collection,
                        :comment,
                        :hint,
                        :placeholder
          attr_reader :blueprint_section, :validation, :collection

          def initialize(blueprint_section, params={})
            @blueprint_section = blueprint_section
            super params
          end

          def validation_attributes=(params={})
            @validation = Validation.new params
          end

          def collection_attributes=(params={})
            @collection = Collection.new blueprint_section, params
          end

          def validation
            @validation ||= Validation.new
          end

          def collection
            @collection ||= Collection.new blueprint_section
          end

          def dropdowns_config
            @dropdowns_config ||= Settings::DropdownsConfig.config
          end

          def type_collection
            @type_collection ||= dropdowns_config[:input_types]
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
