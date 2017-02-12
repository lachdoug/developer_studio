class App
  class Blueprint
    class EnvironmentVariables
      class EnvironmentVariable
        class Input
          class Validation

            include ActiveModel::Model

            attr_accessor :required, :pattern, :message

            def form_data
              { required: ActiveRecord::Type::Boolean.new.cast(required),
                pattern: pattern,
                message: message }
            end

          end
        end
      end
    end
  end
end
