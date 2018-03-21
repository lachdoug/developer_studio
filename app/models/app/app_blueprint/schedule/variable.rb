class App
  class AppBlueprint
    class Schedule
      class Variable

        include ActiveModel::Model

        attr_accessor :schedule, :value
        attr_reader :name

        def name=(name)
          self.class.send(:attr_accessor, "#{name}_confirmation")
          @name = name
        end

        def resolve_strings_collection
          schedule.dropdowns_config[:resolve_strings]
        end

        def form_data
          {
            name => value
          }
        end

        def variable_definition
          @variable_definition ||=
          schedule.blueprint_actionator_variables.find { |v| v[:name] == name.to_s }
        end

      end
    end
  end
end
