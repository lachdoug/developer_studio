class App
  class AppBlueprint
    class Schedule
      class Variable

        include ActiveModel::Model

        attr_accessor :schedule, :resolve_string, :resolve
        attr_reader :name, :value

        def name=(name)
          self.class.send(:attr_accessor, "#{name}_confirmation")
          @name = name
        end

        def value=(value)
          if value.present? && value.is_a?(String) && test_for_resolve_regex.match(value)
            @resolve = '1'
            @resolve_string = value
          else
            @value = value
          end
        end

        def test_for_resolve_regex
          /^.*(_Engines_System|_Engines_Builder|_Engines_Environment)\(.*\).*/
        end

        def form_data
          {
            name => form_data_value
          }
        end

        def form_data_value
          return resolve_string if resolve == '1'
          return cast_as_boolean(value) if variable_definition.present? && type.to_sym == :boolean
          value
        end

        def type
          variable_definition.dig(:input, :type)
        end

        def collection_items
          variable_definition.dig(:input, :collection, :items)
        end

        def collection_include_blank
          variable_definition.dig(:input, :collection, :include_blank)
        end

        def label
          variable_definition.dig(:input, :label)
        end

        def title
          variable_definition.dig(:input, :title)
        end

        def hint
          variable_definition.dig(:input, :hint)
        end

        def comment
          variable_definition.dig(:input, :comment)
        end

        def placeholder
          variable_definition.dig(:input, :placeholder)
        end

        def pattern
          variable_definition.dig(:input, :validation, :pattern)
        end

        def validation_message
          variable_definition.dig(:input, :validation, :message)
        end

        def required
          variable_definition.dig(:input, :mandatory)
        end

        def variable_definition
          @variable_definition ||=
          schedule.blueprint_actionator_variables.find { |v| v[:name] == name.to_s }
          #
          # byebug unless @variable_definition
          # @variable_definition


        end

        def collection_for(select_collection)
          return [] unless variable_definition[:select_collection].present?
          JSON.parse(variable_definition[:select_collection])
        rescue
          [variable_definition[:select_collection]]
        end

      end
    end
  end
end
