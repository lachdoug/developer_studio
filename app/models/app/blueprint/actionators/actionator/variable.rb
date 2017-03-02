class App
  class Blueprint
    class Actionators
      class Actionator
        class Variable

          include ActiveModel::Model

          attr_accessor :name,
                        :value,
                        :mandatory
          attr_reader :input

          def input_attributes=(params={})
            @input = Input.new params
          end

          def build_input
            @input = Input.new.tap(&:build_validation).tap(&:build_collection)
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
end
