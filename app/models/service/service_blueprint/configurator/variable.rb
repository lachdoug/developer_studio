class Service
  class ServiceBlueprint
    class Configurator
      class Variable < ::Blueprint::SectionNestedCollectionItem

        attr_accessor :name, :value, :mandatory
        # attr_reader :input

        def input_attributes=(params={})
          @input = Input.new blueprint_section, params
        end

        def input
          @input ||= Input.new(blueprint_section)
        end

        def form_data
          {
            name: name,
            value: value,
            mandatory: cast_as_boolean(mandatory),
            input: input.form_data
          }
        end

      end
    end
  end
end
