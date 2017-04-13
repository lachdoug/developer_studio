class App
  class Blueprint
    class EnvironmentVariables
      class EnvironmentVariable
        class Input
          class Collection
            class Item

              include ActiveModel::Model

              attr_accessor :value, :label

              def form_data
                { value => label }
              end

            end
          end
        end
      end
    end
  end
end
