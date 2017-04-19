class Service
  class Blueprint
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
