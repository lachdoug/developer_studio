class App
  class Blueprint
    class Actionator
      class Variable

        include ActiveModel::Model

        attr_accessor :index, :new_record,
                      :name, :value, :mandatory
        attr_reader :blueprint_section, :input

        def initialize(blueprint_section, params)
          @blueprint_section = blueprint_section
          super params
        end

        def to_s
          name || 'New'
        end

        def disable_moveup
          index == 0 || new_record
        end

        def update(params)
          assign_attributes params
          blueprint_section.save
        end

        def input_attributes=(params={})
          @input = Input.new blueprint_section, params
        end

        def build_input
          @input = Input.new(blueprint_section).tap(&:build_validation).tap(&:build_collection)
        end

        def form_data
          {
            name: name,
            value: value,
            mandatory: ActiveRecord::Type::Boolean.new.cast(mandatory),
            input: input.form_data
          }
        end

      end
    end
  end
end
