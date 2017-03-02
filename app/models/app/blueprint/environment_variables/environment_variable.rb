class App
  class Blueprint
    class EnvironmentVariables
      class EnvironmentVariable

        include ActiveModel::Model

        attr_accessor :name,
                      :value,
                      :mandatory,
                      :immutable,
                      :ask_at_build_time,
                      :build_time_only
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
            ask_at_build_time: ActiveRecord::Type::Boolean.new.cast(ask_at_build_time),
            build_time_only: ActiveRecord::Type::Boolean.new.cast(build_time_only),
            immutable: ActiveRecord::Type::Boolean.new.cast(immutable),
            input: input.form_data
          }
        end

      end
    end
  end
end
