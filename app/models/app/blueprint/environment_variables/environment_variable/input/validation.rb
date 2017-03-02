class App
  class Blueprint
    class EnvironmentVariables
      class EnvironmentVariable
        class Input
          class Validation

            include ActiveModel::Model

            attr_accessor :pattern, :message

            def form_data
              { pattern: pattern,
                message: message }
            end

          end
        end
      end
    end
  end
end
