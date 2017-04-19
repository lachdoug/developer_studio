class Service
  class ServiceBlueprint
    class EnvironmentVariable
      class Input
        class Collection
          class Item

            include ActiveModel::Model

            attr_accessor :index, :new_record, :value, :label

            def form_data
              { value => label }
            end

            def to_s
              name || 'New'
            end

            def disable_moveup
              index == 0 || new_record
            end

          end
        end
      end
    end
  end
end
